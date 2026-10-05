#include "AbilityPracticeProgression.h"
#include "AbilityPracticeCatalog.h"
#include "AbilityPracticeActions.h"

#include <array>
#include <cassert>
#include <iostream>

using namespace AbilityPractice;

void CheckActions()
{
    ActionLedger<2> actions(501);
    ActionToken const first = actions.Begin(1001);
    assert(first.Session == 501 && first.Sequence == 1 && actions.Active() == 1);
    assert(actions.Consume(first, 1001, false) == ActionResult::Unqualified);
    assert(actions.Consume(first, 1002, true) == ActionResult::Invalid);
    assert(actions.Consume({ 502, first.Sequence }, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume({ 501, 99 }, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume({}, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume(first, 1001, true) == ActionResult::Award);
    for (std::uint32_t event = 0; event < 1000; ++event)
        assert(actions.Consume(first, 1001, true) == ActionResult::AlreadyAwarded);
    assert(actions.Consume(first, 1001, false) == ActionResult::AlreadyAwarded);

    ActionToken const second = actions.Begin(1001);
    assert(second.Sequence == 2 && actions.Active() == 2);
    assert(actions.Begin(1001).Sequence == 0 && actions.Active() == 2);
    assert(actions.Consume(second, 1001, true) == ActionResult::Award);
    assert(!actions.End({ 502, first.Sequence }));
    assert(actions.End(first) && actions.Active() == 1);
    assert(!actions.End(first));
    assert(actions.Consume(first, 1001, true) == ActionResult::Invalid);
    ActionToken const third = actions.Begin(1002);
    assert(third.Sequence == 3 && actions.Active() == 2);
    assert(actions.Consume(first, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume(third, 1002, true) == ActionResult::Award);
    assert(actions.End(second) && actions.End(third) && actions.Active() == 0);
    assert(actions.Begin(0).Sequence == 0 && actions.Active() == 0);

    ActionLedger<2> nextSession(502);
    ActionToken const next = nextSession.Begin(1001);
    assert(next.Sequence == 1);
    assert(nextSession.Consume(first, 1001, true) == ActionResult::Invalid);
    assert(nextSession.Consume(next, 1001, true) == ActionResult::Award);
    ActionLedger<0> empty(501);
    assert(empty.Begin(1001).Sequence == 0);
    ActionLedger<2> invalid(0);
    assert(invalid.Begin(1001).Sequence == 0);
}

void CheckCatalog(TrainingPolicy policy)
{
    std::array const ranks = { AbilityRank{ 101, 1, { 4, 1 } }, AbilityRank{ 102, 2, { 16, 20 } },
        AbilityRank{ 103, 3, { 24, 40 } } };
    std::array const caps = { ProficiencyCap{ 1, 10 }, ProficiencyCap{ 16, 30 }, ProficiencyCap{ 24, 60 } };
    AbilityDefinition const ability{ 24, 1001, AbilityKind::Ranked, ranks, caps };
    std::array const catalog = { ability };
    assert(ValidateCatalog(catalog) == CatalogError::None);
    assert(CapAtLevel(ability, 1) == 10);
    assert(CapAtLevel(ability, 15) == 10);
    assert(CapAtLevel(ability, 16) == 30);
    assert(CapAtLevel(ability, 100) == 60);
    assert(CapAtLevel(ability, 0) == 0);

    std::array<std::uint32_t, 0> const unknown{};
    std::array const first = { 101U };
    std::array const second = { 102U };
    std::array const firstTwo = { 101U, 102U };
    assert(DescribeRank(ability, 0, policy, { 1, 0 }, 4, unknown, true).State ==
        RankState::AcquireIntroductoryAbility);
    assert(DescribeRank(ability, 0, policy, { 1, 0 }, 3, unknown, true).State ==
        RankState::NeedsCharacterLevel);
    assert(DescribeRank(ability, 0, policy, { 1, 0 }, 80, unknown, false).State ==
        RankState::MissingPrerequisite);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 80, unknown, true).State ==
        RankState::MissingPrerequisite);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 80, first, false).State ==
        RankState::MissingPrerequisite);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 80, first, true).State == RankState::Ready);
    assert(DescribeRank(ability, 1, policy, { 10, 0 }, 80, first, true).State == RankState::NeedsPractice);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 15, first, true).State == RankState::NeedsCharacterLevel);
    assert(DescribeRank(ability, 1, policy, { 10, 0 }, 15, first, true).State == RankState::NeedsBoth);
    assert(DescribeRank(ability, 1, policy, { 1, 0 }, 1, second, false).State == RankState::Learned);
    RankView const locked = DescribeRank(ability, 2, policy, { 23, 18 }, 16, firstTwo, true);
    assert(locked.State == RankState::NeedsBoth && locked.Practice.Status == ForecastStatus::BeyondCap);
    RankView const trainable = DescribeRank(ability, 2, policy, { 23, 18 }, 24, firstTwo, true);
    assert(trainable.State == RankState::NeedsPractice && trainable.Practice.Uses == 492);
    assert(DescribeRank(ability, 3, policy, { 1, 0 }, 80, first, true).State == RankState::Invalid);
    assert(DescribeRank(ability, 0, policy, { 0, 0 }, 80, first, true).State == RankState::Invalid);

    Progress const seeded = SeedLearnedRanks(ability, { 1, 0 }, second);
    assert(seeded.Proficiency == 20 && seeded.Points == 0);
    Progress const retained = SeedLearnedRanks(ability, { 23, 18 }, second);
    assert(retained.Proficiency == 23 && retained.Points == 18);
    assert(SeedLearnedRanks(ability, { 1, 0 }, unknown).Proficiency == 1);

    AbilityDefinition changed = ability;
    changed.ClassId = 0;
    assert(ValidateDefinition(changed) == CatalogError::InvalidIdentity);
    changed = ability;
    changed.Kind = AbilityKind::Fixed;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    changed.Kind = AbilityKind::Mastery;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    changed.Kind = static_cast<AbilityKind>(99);
    assert(ValidateDefinition(changed) == CatalogError::InvalidKind);
    changed = ability;
    changed.Ranks = std::span(ranks).first(1);
    changed.Kind = AbilityKind::Fixed;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    changed.Caps = {};
    assert(ValidateDefinition(changed) == CatalogError::None);
    assert(CapAtLevel(changed, 80) == 1);
    changed.Kind = AbilityKind::Mastery;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    changed.Caps = caps;
    assert(ValidateDefinition(changed) == CatalogError::None);

    std::array duplicate = { ability, ability };
    assert(ValidateCatalog(duplicate) == CatalogError::DuplicateAbility);
    duplicate[1].AbilityId = 1002;
    assert(ValidateCatalog(duplicate) == CatalogError::DuplicateSpell);
    duplicate[1].ClassId = 25;
    assert(ValidateCatalog(duplicate) == CatalogError::None);

    std::array brokenRanks = ranks;
    brokenRanks[1].RankNumber = 3;
    changed = ability;
    changed.Ranks = brokenRanks;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    brokenRanks = ranks;
    brokenRanks[1].SpellId = 101;
    assert(ValidateDefinition(changed) == CatalogError::DuplicateSpell);
    brokenRanks = ranks;
    brokenRanks[1].Requirement.CharacterLevel = 2;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    brokenRanks = ranks;
    brokenRanks[1].Requirement.Proficiency = 50;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    brokenRanks = ranks;
    brokenRanks[0].Requirement.Proficiency = 2;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);

    std::array brokenCaps = caps;
    changed = ability;
    changed.Caps = brokenCaps;
    brokenCaps[0].CharacterLevel = 2;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    brokenCaps = caps;
    brokenCaps[1].CharacterLevel = 1;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    brokenCaps = caps;
    brokenCaps[1].Proficiency = 0;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    brokenCaps = caps;
    brokenCaps[2].Proficiency = 20;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
}

int main()
{
    std::array const bands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };
    TrainingPolicy const policy{ bands };
    CheckCatalog(policy);
    CheckActions();
    assert(ValidPolicy(policy));
    assert(UsesUntil(policy, { 23, 18 }, 24, 80).Uses == 12);
    assert(UsesUntil(policy, { 27, 24 }, 28, 80).Uses == 6);
    assert(UsesUntil(policy, { 12, 18 }, 13, 80).Uses == 6);
    assert(UsesUntil(policy, { 12, 18 }, 25, 80).Uses == 261);
    assert(UsesUntil(policy, { 23, 18 }, 40, 80).Uses == 492);
    assert(UsesUntil(policy, { 23, 18 }, 81, 80).Status == ForecastStatus::BeyondCap);
    assert(UsesUntil(policy, { 40, 0 }, 40, 80).Status == ForecastStatus::Complete);

    Award const capped = ApplyQualifyingUse(policy, { 79, 29 }, 80);
    assert(capped.Status == AwardStatus::Applied);
    assert(capped.State.Proficiency == 80 && capped.State.Points == 0);
    assert(ApplyQualifyingUse(policy, capped.State, 80).Status == AwardStatus::Capped);
    Award const retained = ApplyQualifyingUse(policy, { 80, 4 }, 40);
    assert(retained.Status == AwardStatus::Capped);
    assert(retained.State.Proficiency == 80 && retained.State.Points == 4);
    assert(UsesUntil(policy, retained.State, 70, 40).Status == ForecastStatus::Complete);

    std::array const transitions = { TrainingBand{ 1, 7, 5 }, TrainingBand{ 3, 2, 1 } };
    TrainingPolicy const transitionPolicy{ transitions };
    Award const carried = ApplyQualifyingUse(transitionPolicy, { 2, 6 }, 20);
    assert(carried.State.Proficiency == 5 && carried.State.Points == 0);
    assert(UsesUntil(transitionPolicy, { 2, 6 }, 4, 20).Uses == 1);
    assert(UsesUntil(transitionPolicy, { 2, 6 }, 6, 20).Uses == 3);
    Award const cappedCarry = ApplyQualifyingUse(transitionPolicy, { 2, 6 }, 4);
    assert(cappedCarry.State.Proficiency == 4 && cappedCarry.State.Points == 0);

    std::array const hugeBands = { TrainingBand{ 1, 4294967295U, 1 } };
    assert(UsesUntil({ hugeBands }, { 1, 0 }, 4294967295U, 4294967295U).Uses == 18446744060824649730ULL);
    std::array const hugeAward = { TrainingBand{ 1, 1, 4294967295U } };
    Award const huge = ApplyQualifyingUse({ hugeAward }, { 1, 0 }, 4294967295U);
    assert(huge.State.Proficiency == 4294967295U && huge.State.Points == 0);
    assert(UsesUntil({ hugeAward }, { 1, 0 }, 4294967295U, 4294967295U).Uses == 1);

    std::array const invalidOrder = { TrainingBand{ 1, 30, 1 }, TrainingBand{ 1, 30, 2 } };
    std::array const invalidStart = { TrainingBand{ 2, 30, 1 } };
    std::array const zeroRate = { TrainingBand{ 1, 30, 0 } };
    std::array const zeroCost = { TrainingBand{ 1, 0, 1 } };
    assert(!ValidPolicy({ {} }));
    assert(!ValidPolicy({ invalidOrder }));
    assert(!ValidPolicy({ invalidStart }));
    assert(!ValidPolicy({ zeroRate }));
    assert(!ValidPolicy({ zeroCost }));
    assert(ApplyQualifyingUse(policy, { 0, 0 }, 80).Status == AwardStatus::Invalid);
    assert(ApplyQualifyingUse(policy, { 1, 30 }, 80).Status == AwardStatus::Invalid);
    assert(ApplyQualifyingUse(policy, { 1, 0 }, 0).Status == AwardStatus::Invalid);
    assert(UsesUntil(policy, { 1, 0 }, 0, 80).Status == ForecastStatus::Invalid);
    assert(UsesUntil({ zeroRate }, { 1, 0 }, 2, 80).Status == ForecastStatus::Invalid);

    Milestone const rank{ 24, 40 };
    assert(EvaluateMilestone(rank, { 23, 18 }, 16, true) == MilestoneStatus::NeedsBoth);
    assert(EvaluateMilestone(rank, { 40, 0 }, 16, true) == MilestoneStatus::NeedsCharacterLevel);
    assert(EvaluateMilestone(rank, { 23, 18 }, 24, true) == MilestoneStatus::NeedsPractice);
    assert(EvaluateMilestone(rank, { 40, 0 }, 24, true) == MilestoneStatus::Ready);
    assert(EvaluateMilestone(rank, { 40, 0 }, 24, false) == MilestoneStatus::MissingPrerequisite);
    assert(EvaluateMilestone({ 0, 0 }, { 1, 0 }, 16, true) == MilestoneStatus::Invalid);

    std::uint32_t comparisons = 0;
    for (TrainingPolicy const sample : { policy, transitionPolicy })
    {
        for (std::uint32_t proficiency = 1; proficiency < 30; ++proficiency)
        {
            std::uint32_t const cost = sample.Bands[Detail::BandIndex(sample, proficiency)].PointsPerLevel;
            for (std::uint32_t points = 0; points < cost; ++points)
            {
                for (std::uint32_t target = proficiency + 1; target <= 30; ++target)
                {
                    Progress observed{ proficiency, points };
                    std::uint64_t actualUses = 0;
                    while (observed.Proficiency < target)
                    {
                        observed = ApplyQualifyingUse(sample, observed, 30).State;
                        ++actualUses;
                    }
                    Forecast const expected = UsesUntil(sample, { proficiency, points }, target, 30);
                    assert(expected.Status == ForecastStatus::Training && expected.Uses == actualUses);
                    ++comparisons;
                }
            }
        }
    }
    std::cout << "PASS: " << comparisons << " forecast/award comparisons and progression boundary cases\n";
}
