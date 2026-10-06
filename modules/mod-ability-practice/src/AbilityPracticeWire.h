#ifndef ABILITY_PRACTICE_WIRE_H
#define ABILITY_PRACTICE_WIRE_H

#include "AbilityPracticeMenu.h"

#include <sstream>
#include <locale>
#include <string>
#include <string_view>
#include <vector>

namespace AbilityPractice
{
inline bool ValidForecast(Forecast forecast)
{
    return forecast.Status == ForecastStatus::Training ? forecast.Uses > 0 :
        forecast.Status >= ForecastStatus::Invalid && forecast.Status <= ForecastStatus::BeyondCap &&
        forecast.Uses == 0;
}

namespace Detail
{
inline bool SameRankView(RankView const& left, RankView const& right)
{
    return left.SpellId == right.SpellId && left.RankNumber == right.RankNumber &&
        left.Requirement.CharacterLevel == right.Requirement.CharacterLevel &&
        left.Requirement.Proficiency == right.Requirement.Proficiency && left.State == right.State &&
        left.Practice.Status == right.Practice.Status && left.Practice.Uses == right.Practice.Uses;
}

inline bool ConsistentTypedRoadmap(AbilityView const& view, std::uint32_t characterLevel)
{
    if (view.Ranks.empty() || view.Ranks.front().Requirement.Proficiency != 1 ||
        (view.Kind == AbilityKind::Ranked && view.Ranks.size() < 2) ||
        (view.Kind == AbilityKind::Mastery && view.Ranks.size() != 1))
        return false;
    std::uint32_t learned = 0;
    std::uint32_t display = view.Ranks.front().SpellId;
    for (std::size_t index = 0; index < view.Ranks.size(); ++index)
    {
        RankView const& rank = view.Ranks[index];
        if (rank.RankNumber != index + 1)
            return false;
        if (rank.State == RankState::Learned)
        {
            learned = rank.RankNumber;
            display = rank.SpellId;
        }
    }
    if (view.LearnedRank != learned || view.DisplaySpellId != display ||
        (view.NextRank.has_value() != (learned < view.Ranks.size())) ||
        (view.NextRank && !SameRankView(*view.NextRank, view.Ranks[learned])))
        return false;
    bool const introLevelMet = characterLevel >= view.Ranks.front().Requirement.CharacterLevel;
    switch (view.Availability)
    {
        case PracticeAvailability::AcquireAbility:
            return !learned && introLevelMet && view.NextPoint.Status == ForecastStatus::Invalid;
        case PracticeAvailability::MissingPrerequisite:
            return view.NextPoint.Status == ForecastStatus::Invalid;
        case PracticeAvailability::NeedsCharacterLevel:
            return !introLevelMet && view.NextPoint.Status == ForecastStatus::Invalid;
        case PracticeAvailability::Training:
            return learned && introLevelMet && view.State.Proficiency < view.Cap &&
                view.NextPoint.Status == ForecastStatus::Training;
        case PracticeAvailability::Capped:
            return learned && introLevelMet && view.State.Proficiency >= view.Cap &&
                view.NextPoint.Status == ForecastStatus::BeyondCap;
        case PracticeAvailability::Fixed:
            return view.Kind == AbilityKind::Fixed && learned && introLevelMet;
        case PracticeAvailability::Invalid:
            return false;
    }
    return false;
}

inline bool ConsistentTypedMastery(AbilityView const& view, std::uint32_t characterLevel)
{
    if (view.Kind != AbilityKind::Mastery)
        return view.Rewards.empty();
    if ((view.Route != PracticeRoute::Healing && view.Route != PracticeRoute::Damage) ||
        view.Rewards.empty() || view.Rewards.size() > MaximumMasteryRewards)
        return false;
    std::uint32_t previousLevel = view.Ranks.front().Requirement.CharacterLevel;
    std::uint32_t previousProficiency = 1;
    std::uint32_t previousBonus = 0;
    for (MasteryRewardView const& entry : view.Rewards)
    {
        MasteryReward const& reward = entry.Reward;
        if (reward.Requirement.CharacterLevel < previousLevel || reward.Requirement.CharacterLevel > 255 ||
            reward.Requirement.Proficiency <= previousProficiency ||
            !ValidMasteryEffect(reward, view.Route == PracticeRoute::Healing) ||
            MasteryBonusAmount(reward) <= previousBonus ||
            MasteryBonusAmount(reward) > MaximumMasteryBasisPoints || !ValidForecast(entry.Practice))
            return false;
        bool const levelMet = characterLevel >= reward.Requirement.CharacterLevel;
        bool const practiceMet = view.State.Proficiency >= reward.Requirement.Proficiency;
        RankState const expectedState = view.Availability == PracticeAvailability::MissingPrerequisite ?
            RankState::MissingPrerequisite : !view.LearnedRank ? RankState::AcquireIntroductoryAbility :
            levelMet && practiceMet ? RankState::Learned : levelMet ? RankState::NeedsPractice :
            practiceMet ? RankState::NeedsCharacterLevel : RankState::NeedsBoth;
        ForecastStatus const expectedForecast = practiceMet ? ForecastStatus::Complete :
            reward.Requirement.Proficiency > view.Cap ? ForecastStatus::BeyondCap : ForecastStatus::Training;
        if (entry.State != expectedState || entry.Practice.Status != expectedForecast)
            return false;
        previousLevel = reward.Requirement.CharacterLevel;
        previousProficiency = reward.Requirement.Proficiency;
        previousBonus = MasteryBonusAmount(reward);
    }
    return view.Cap <= view.Rewards.back().Reward.Requirement.Proficiency;
}

template<typename... Values>
std::string WireLine(char kind, Values... values)
{
    std::ostringstream stream;
    stream.imbue(std::locale::classic());
    stream << kind;
    ((stream << '|' << values), ...);
    return stream.str();
}

inline std::vector<std::string> PackTypedMessages(std::span<std::string const> lines, std::uint32_t revision)
{
    std::vector<std::string> packed;
    packed.reserve(lines.size());
    std::string const prefix = WireLine('D', revision) + '|';
    std::string batch;
    std::size_t records = 0;
    auto const flush = [&packed, &batch, &records]()
    {
        if (!batch.empty())
        {
            packed.push_back(std::move(batch));
            batch.clear();
        }
        records = 0;
    };
    for (std::string const& line : lines)
    {
        if (line.empty() || std::string_view("ACPRTKLMNGOJ").find(line.front()) == std::string_view::npos)
        {
            flush();
            packed.push_back(line);
            continue;
        }
        std::string const recordPrefix = std::string(1, line.front()) + '|' + std::to_string(revision) + '|';
        if (!line.starts_with(recordPrefix))
        {
            flush();
            packed.push_back(line);
            continue;
        }
        std::string const compact = std::string(1, line.front()) + '|' + line.substr(recordPrefix.size());
        if (prefix.size() + compact.size() > 240)
        {
            flush();
            packed.push_back(line);
            continue;
        }
        if (!batch.empty() && (records == 32 || batch.size() + 1 + compact.size() > 240))
            flush();
        if (batch.empty())
            batch = prefix + compact;
        else
            batch += ';' + compact;
        ++records;
    }
    flush();
    return packed;
}
}

enum class ProgressIssue : std::uint32_t
{
    Unreadable = 1,
    DefinitionMismatch = 2
};

inline std::optional<std::string> EncodeMenuProgressFailure(std::uint32_t revision, std::uint32_t classId,
    std::uint32_t abilityId, std::uint32_t spellId, std::uint64_t generation,
    ProgressIssue issue = ProgressIssue::Unreadable)
{
    if (!revision || !classId || classId > 255 || !abilityId || !spellId || !generation ||
        (issue != ProgressIssue::Unreadable && issue != ProgressIssue::DefinitionMismatch))
        return std::nullopt;
    return Detail::WireLine('F', TypedMenuSchemaVersion, revision, classId, abilityId, spellId,
        static_cast<std::uint32_t>(issue), generation);
}

inline std::optional<std::vector<std::string>> EncodeMenuSnapshot(std::uint32_t classId,
    std::uint32_t characterLevel, std::uint32_t revision, std::span<AbilityView const> abilities,
    std::optional<SessionPractice> session = std::nullopt, bool includeRoadmap = false, bool includeKinds = false,
    std::uint64_t generation = 0, std::optional<std::uint32_t> realmMaximumLevel = std::nullopt,
    std::optional<SessionLearningView> learning = std::nullopt,
    std::optional<SessionMasteryView> mastery = std::nullopt)
{
    if (!classId || classId > 255 || !characterLevel || characterLevel > 255 || !revision || abilities.size() > 512)
        return std::nullopt;
    if ((includeRoadmap && !session) || (includeKinds && (!includeRoadmap || !generation)))
        return std::nullopt;
    if (includeKinds && realmMaximumLevel && (!*realmMaximumLevel || *realmMaximumLevel > 255))
        return std::nullopt;
    if (learning && (!includeKinds || !realmMaximumLevel || learning->Events.size() > MaximumSessionLearns ||
            learning->Total < learning->Events.size() ||
            (learning->Available && learning->Events.size() !=
                std::min(learning->Total, static_cast<std::uint64_t>(MaximumSessionLearns))) ||
            (!learning->Available && (learning->Total || !learning->Events.empty()))))
        return std::nullopt;
    if (mastery && (!includeKinds || mastery->Events.size() > MaximumSessionMasteries ||
        mastery->Total < mastery->Events.size() || (mastery->Available && mastery->Events.size() !=
            std::min(mastery->Total, static_cast<std::uint64_t>(MaximumSessionMasteries))) ||
        (!mastery->Available && (mastery->Total || !mastery->Events.empty()))))
        return std::nullopt;
    std::size_t rankCount = 0;
    std::size_t rewardCount = 0;
    for (AbilityView const& view : abilities)
    {
        if (!includeKinds && (view.Kind == AbilityKind::Mastery || !view.Rewards.empty()))
            return std::nullopt;
        rewardCount += view.Rewards.size();
        if (rewardCount > MaximumClassMasteryRewards)
            return std::nullopt;
    }
    if (includeRoadmap)
        for (AbilityView const& view : abilities)
        {
            if (view.Ranks.empty() || view.Ranks.size() > 64)
                return std::nullopt;
            rankCount += view.Ranks.size();
            if (rankCount > 2048)
                return std::nullopt;
        }
    std::vector<std::string> lines;
    lines.reserve(abilities.size() * (includeKinds ? 6 : includeRoadmap ? 4 : 3) + rankCount + rewardCount + 3);
    lines.push_back(Detail::WireLine('B', includeKinds ? TypedMenuSchemaVersion :
        includeRoadmap ? RoadmapMenuSchemaVersion :
        session ? SessionMenuSchemaVersion : MenuSchemaVersion,
        revision, classId, characterLevel, abilities.size()));
    if (includeKinds)
    {
        lines.front() += '|' + std::to_string(generation);
        if (realmMaximumLevel)
            lines.front() += '|' + std::to_string(*realmMaximumLevel);
        if (learning)
            lines.front() += '|' + std::to_string(learning->Available ? 1 : 0) + '|' +
                std::to_string(learning->Events.size()) + '|' + std::to_string(learning->Total);
    }
    for (std::size_t index = 0; index < abilities.size(); ++index)
    {
        AbilityView const& view = abilities[index];
        if (view.SchemaVersion != MenuSchemaVersion || view.ClassId != classId || !view.AbilityId ||
            !view.DisplaySpellId || !view.State.Proficiency || !view.Cap ||
            view.Availability < PracticeAvailability::AcquireAbility || view.Availability > PracticeAvailability::Fixed ||
            !ValidForecast(view.NextPoint) || view.State.Points > std::numeric_limits<std::uint32_t>::max() ||
            (view.PointsPerLevel && view.State.Points >= view.PointsPerLevel) ||
            ((view.Availability == PracticeAvailability::Training || view.Availability == PracticeAvailability::Capped) &&
                !view.PointsPerLevel))
            return std::nullopt;
        for (std::size_t other = 0; other < index; ++other)
            if (abilities[other].AbilityId == view.AbilityId)
                return std::nullopt;
        if (includeKinds)
        {
            if (!Detail::ConsistentTypedRoadmap(view, characterLevel) ||
                !Detail::ConsistentTypedMastery(view, characterLevel))
                return std::nullopt;
            if (view.RuleSet < 1 || view.RuleSet > 6 ||
                ((view.RuleSet == HumanPvEScriptedHealRuleSet || view.RuleSet == 6) &&
                    (view.Route != PracticeRoute::Healing || view.Kind != AbilityKind::Ranked)) ||
                view.Route < PracticeRoute::Damage ||
                view.Route > PracticeRoute::DamageOrRoot ||
                ((view.Kind == AbilityKind::Fixed) != (view.Route == PracticeRoute::Fixed)))
                return std::nullopt;
            if (view.Kind != AbilityKind::Ranked && view.Kind != AbilityKind::Mastery && view.Kind != AbilityKind::Fixed)
                return std::nullopt;
            if (view.Kind != AbilityKind::Fixed && view.Availability == PracticeAvailability::Fixed)
                return std::nullopt;
            if (view.Kind == AbilityKind::Fixed && (view.LearnedRank > view.Ranks.size() ||
                view.Cap != 1 || view.State.Proficiency != 1 || view.State.Points || view.PointsPerLevel ||
                view.NextPoint.Status != ForecastStatus::Invalid ||
                std::any_of(view.Ranks.begin(), view.Ranks.end(), [](RankView const& rank)
                {
                    return rank.Requirement.Proficiency != 1 || rank.Practice.Status != ForecastStatus::Invalid ||
                        (rank.State != RankState::Learned && rank.State != RankState::AcquireIntroductoryAbility &&
                            rank.State != RankState::MissingPrerequisite && rank.State != RankState::NeedsCharacterLevel);
                })))
                return std::nullopt;
            if (view.AcquisitionSourceId > 4 || (view.RuleSet > 3) != view.Catchup.has_value())
                return std::nullopt;
            if (view.ReplacementSpellId)
            {
                if (view.Availability != PracticeAvailability::MissingPrerequisite ||
                    std::any_of(view.Ranks.begin(), view.Ranks.end(), [&view](RankView const& rank)
                        { return rank.SpellId == view.ReplacementSpellId; }))
                    return std::nullopt;
                lines.push_back(Detail::WireLine('J', revision, index + 1, view.ReplacementSpellId));
            }
            if (view.Catchup)
            {
                CatchupView const& catchup = *view.Catchup;
                bool const boosted = view.State.Proficiency < view.Cap &&
                    view.Cap - view.State.Proficiency >= catchup.Gap;
                std::uint64_t const expected = std::uint64_t(catchup.BasePointsPerUse) *
                    (boosted ? catchup.Multiplier : 1);
                if (view.Kind == AbilityKind::Fixed || !catchup.Gap || catchup.Gap > 500 ||
                    catchup.Multiplier < 2 || catchup.Multiplier > 4 || !catchup.BasePointsPerUse ||
                    expected != catchup.EffectivePointsPerUse || boosted != catchup.Boosted)
                    return std::nullopt;
                lines.push_back(Detail::WireLine('G', revision, index + 1, catchup.Gap, catchup.Multiplier,
                    catchup.BasePointsPerUse, catchup.EffectivePointsPerUse, catchup.Boosted ? 1 : 0));
            }
            if (!view.Session.Available && (view.Session.Uses || view.Session.ProficiencyGained))
                return std::nullopt;
            lines.push_back(Detail::WireLine('T', revision, index + 1, static_cast<std::uint32_t>(view.Kind) + 1,
                view.Session.Available ? 1 : 0, view.Session.Uses, view.Session.ProficiencyGained,
                static_cast<std::uint32_t>(view.Route), view.RuleSet, view.Rewards.size()));
            if (view.AcquisitionSourceId)
                lines.back() += '|' + std::to_string(view.AcquisitionSourceId);
            for (std::size_t ordinal = 0; ordinal < view.Rewards.size(); ++ordinal)
            {
                MasteryRewardView const& reward = view.Rewards[ordinal];
                lines.push_back(Detail::WireLine('M', revision, index + 1, ordinal + 1,
                    reward.Reward.Requirement.CharacterLevel, reward.Reward.Requirement.Proficiency,
                    MasteryBonusAmount(reward.Reward), static_cast<std::uint32_t>(reward.State),
                    static_cast<std::uint32_t>(reward.Practice.Status), reward.Practice.Uses));
                if (reward.Reward.DamageBonusBasisPoints)
                    lines.back() += "|2";
            }
            if (view.NextTrainingCap)
            {
                ProficiencyCap const& cap = *view.NextTrainingCap;
                if (view.Kind == AbilityKind::Fixed || cap.CharacterLevel <= characterLevel || cap.CharacterLevel > 255 ||
                    cap.CharacterLevel < view.Ranks.front().Requirement.CharacterLevel ||
                    cap.Proficiency <= std::max(view.Cap, view.State.Proficiency))
                    return std::nullopt;
                lines.push_back(Detail::WireLine('C', revision, index + 1, 1, cap.CharacterLevel, cap.Proficiency));
            }
            else
                lines.push_back(Detail::WireLine('C', revision, index + 1, 0));
        }
        lines.push_back(Detail::WireLine('A', revision, index + 1, view.AbilityId, view.DisplaySpellId,
            view.LearnedRank, view.State.Proficiency, view.State.Points, view.Cap, view.PointsPerLevel,
            static_cast<std::uint32_t>(view.Availability)));
        lines.push_back(Detail::WireLine('P', revision, index + 1,
            static_cast<std::uint32_t>(view.NextPoint.Status), view.NextPoint.Uses));
        if (view.NextRank)
        {
            RankView const& rank = *view.NextRank;
            if (!rank.SpellId || !rank.RankNumber || !rank.Requirement.CharacterLevel ||
                rank.Requirement.CharacterLevel > 255 || !rank.Requirement.Proficiency ||
                rank.State < RankState::Invalid || rank.State > RankState::Ready || !ValidForecast(rank.Practice))
                return std::nullopt;
            lines.push_back(Detail::WireLine('R', revision, index + 1, 1, rank.SpellId, rank.RankNumber,
                rank.Requirement.CharacterLevel, rank.Requirement.Proficiency,
                static_cast<std::uint32_t>(rank.State), static_cast<std::uint32_t>(rank.Practice.Status),
                rank.Practice.Uses));
        }
        else
            lines.push_back(Detail::WireLine('R', revision, index + 1, 0));
        if (includeRoadmap)
        {
            lines.push_back(Detail::WireLine('K', revision, index + 1, view.Ranks.size()));
            for (std::size_t ordinal = 0; ordinal < view.Ranks.size(); ++ordinal)
            {
                RankView const& rank = view.Ranks[ordinal];
                if (!rank.SpellId || !rank.RankNumber || !rank.Requirement.CharacterLevel ||
                    rank.Requirement.CharacterLevel > 255 || !rank.Requirement.Proficiency ||
                    rank.State < RankState::Learned || rank.State > RankState::Ready || !ValidForecast(rank.Practice))
                    return std::nullopt;
                if (ordinal && (rank.RankNumber <= view.Ranks[ordinal - 1].RankNumber ||
                    rank.Requirement.CharacterLevel < view.Ranks[ordinal - 1].Requirement.CharacterLevel ||
                    rank.Requirement.Proficiency < view.Ranks[ordinal - 1].Requirement.Proficiency))
                    return std::nullopt;
                for (std::size_t other = 0; other < ordinal; ++other)
                    if (view.Ranks[other].SpellId == rank.SpellId)
                        return std::nullopt;
                lines.push_back(Detail::WireLine('L', revision, index + 1, ordinal + 1, rank.SpellId,
                    rank.RankNumber, rank.Requirement.CharacterLevel, rank.Requirement.Proficiency,
                    static_cast<std::uint32_t>(rank.State), static_cast<std::uint32_t>(rank.Practice.Status),
                    rank.Practice.Uses));
            }
        }
    }
    if (learning)
        for (std::size_t index = 0; index < learning->Events.size(); ++index)
        {
            SessionLearn const& event = learning->Events[index];
            auto const ability = std::find_if(abilities.begin(), abilities.end(),
                [&event](AbilityView const& view) { return view.AbilityId == event.AbilityId; });
            if (ability == abilities.end() || !std::any_of(ability->Ranks.begin(), ability->Ranks.end(),
                    [&event](RankView const& rank)
                    {
                        return rank.SpellId == event.Rank.SpellId && rank.RankNumber == event.Rank.RankNumber &&
                            rank.Requirement.CharacterLevel == event.Rank.Requirement.CharacterLevel &&
                            rank.Requirement.Proficiency == event.Rank.Requirement.Proficiency;
                    }))
                return std::nullopt;
            lines.push_back(Detail::WireLine('N', revision, index + 1, event.AbilityId, event.Rank.SpellId,
                event.Rank.RankNumber, event.Rank.Requirement.CharacterLevel, event.Rank.Requirement.Proficiency));
        }
    if (mastery)
    {
        lines.push_back(Detail::WireLine('H', revision, mastery->Available ? 1 : 0,
            mastery->Events.size(), mastery->Total));
        for (std::size_t index = 0; index < mastery->Events.size(); ++index)
        {
            auto const& event = mastery->Events[index];
            for (std::size_t prior = 0; prior < index; ++prior)
                if (mastery->Events[prior].AbilityId == event.AbilityId &&
                    mastery->Events[prior].Ordinal == event.Ordinal)
                    return std::nullopt;
            auto const ability = std::find_if(abilities.begin(), abilities.end(),
                [&event](AbilityView const& view) { return view.AbilityId == event.AbilityId; });
            if (ability == abilities.end() || ability->Kind != AbilityKind::Mastery ||
                !event.Ordinal || event.Ordinal > ability->Rewards.size())
                return std::nullopt;
            auto const& reward = ability->Rewards[event.Ordinal - 1].Reward;
            if (reward.Requirement.CharacterLevel != event.Reward.Requirement.CharacterLevel ||
                reward.Requirement.Proficiency != event.Reward.Requirement.Proficiency ||
                reward.HealingBonusBasisPoints != event.Reward.HealingBonusBasisPoints ||
                reward.DamageBonusBasisPoints != event.Reward.DamageBonusBasisPoints)
                return std::nullopt;
            lines.push_back(Detail::WireLine('O', revision, index + 1, event.AbilityId, event.Ordinal,
                reward.Requirement.CharacterLevel, reward.Requirement.Proficiency, MasteryBonusAmount(reward)));
            if (reward.DamageBonusBasisPoints)
                lines.back() += "|2";
        }
    }
    if (session)
    {
        if (!session->Available && (session->Uses || session->ProficiencyGained))
            return std::nullopt;
        lines.push_back(Detail::WireLine('S', revision, session->Available ? 1 : 0,
            session->Uses, session->ProficiencyGained));
    }
    lines.push_back(Detail::WireLine('E', revision));
    for (std::string const& line : lines)
        if (line.size() > 240)
            return std::nullopt;
    if (includeKinds)
        return Detail::PackTypedMessages(lines, revision);
    return lines;
}
}

#endif
