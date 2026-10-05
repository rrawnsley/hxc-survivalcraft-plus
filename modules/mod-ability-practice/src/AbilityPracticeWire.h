#ifndef ABILITY_PRACTICE_WIRE_H
#define ABILITY_PRACTICE_WIRE_H

#include "AbilityPracticeMenu.h"

#include <sstream>
#include <locale>
#include <string>
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
template<typename... Values>
std::string WireLine(char kind, Values... values)
{
    std::ostringstream stream;
    stream.imbue(std::locale::classic());
    stream << kind;
    ((stream << '|' << values), ...);
    return stream.str();
}
}

inline std::optional<std::vector<std::string>> EncodeMenuSnapshot(std::uint32_t classId,
    std::uint32_t characterLevel, std::uint32_t revision, std::span<AbilityView const> abilities,
    std::optional<SessionPractice> session = std::nullopt, bool includeRoadmap = false, bool includeKinds = false)
{
    if (!classId || classId > 255 || !characterLevel || characterLevel > 255 || !revision || abilities.size() > 512)
        return std::nullopt;
    if ((includeRoadmap && !session) || (includeKinds && !includeRoadmap))
        return std::nullopt;
    std::size_t rankCount = 0;
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
    lines.reserve(abilities.size() * (includeKinds ? 5 : includeRoadmap ? 4 : 3) + rankCount + 3);
    lines.push_back(Detail::WireLine('B', includeKinds ? TypedMenuSchemaVersion :
        includeRoadmap ? RoadmapMenuSchemaVersion :
        session ? SessionMenuSchemaVersion : MenuSchemaVersion,
        revision, classId, characterLevel, abilities.size()));
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
            if (view.Kind != AbilityKind::Ranked && view.Kind != AbilityKind::Mastery && view.Kind != AbilityKind::Fixed)
                return std::nullopt;
            if (view.Kind != AbilityKind::Fixed && view.Availability == PracticeAvailability::Fixed)
                return std::nullopt;
            if (view.Kind == AbilityKind::Fixed && (view.Ranks.size() != 1 || view.LearnedRank > 1 ||
                view.Cap != 1 || view.State.Proficiency != 1 || view.State.Points || view.PointsPerLevel ||
                view.NextPoint.Status != ForecastStatus::Invalid || view.Ranks.front().Requirement.Proficiency != 1 ||
                view.Ranks.front().Practice.Status != ForecastStatus::Invalid ||
                (view.Ranks.front().State != RankState::Learned &&
                    view.Ranks.front().State != RankState::AcquireIntroductoryAbility &&
                    view.Ranks.front().State != RankState::MissingPrerequisite &&
                    view.Ranks.front().State != RankState::NeedsCharacterLevel)))
                return std::nullopt;
            if (!view.Session.Available && (view.Session.Uses || view.Session.ProficiencyGained))
                return std::nullopt;
            lines.push_back(Detail::WireLine('T', revision, index + 1, static_cast<std::uint32_t>(view.Kind) + 1,
                view.Session.Available ? 1 : 0, view.Session.Uses, view.Session.ProficiencyGained));
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
    return lines;
}
}

#endif
