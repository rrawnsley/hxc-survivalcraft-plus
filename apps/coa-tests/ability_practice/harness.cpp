#include "AbilityPracticeProgression.h"

#include <array>
#include <cassert>
#include <iostream>

using namespace AbilityPractice;

int main()
{
    std::array const bands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };
    TrainingPolicy const policy{ bands };
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
