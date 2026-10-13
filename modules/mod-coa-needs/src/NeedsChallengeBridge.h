// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef COA_NEEDS_CHALLENGE_BRIDGE_H
#define COA_NEEDS_CHALLENGE_BRIDGE_H

#include <cstdint>
#include <atomic>

namespace CoANeeds
{
using ChallengeReader = bool (*)(uint32_t, float&, float&);
using OldSchoolTrialReader = bool (*)(uint32_t);
using OldSchoolRestedReader = uint32_t (*)(uint32_t);
inline ChallengeReader ReadChallengeNeeds = nullptr;
inline OldSchoolTrialReader IsOldSchoolTrial = nullptr;
inline OldSchoolRestedReader ReadOldSchoolRestedSeconds = nullptr;
inline std::atomic<float> ChallengeMaximum{ 100.0f };
}

#endif
