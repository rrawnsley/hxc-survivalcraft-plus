#ifndef ABILITY_PRACTICE_BUFF_RECEIPTS_H
#define ABILITY_PRACTICE_BUFF_RECEIPTS_H

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <utility>
#include <vector>

namespace CoAAbilityPractice
{
class CastReceipt;
}

namespace AbilityPractice
{
struct CapturedBuffOrigin
{
    std::uint64_t Bit;
    std::weak_ptr<CoAAbilityPractice::CastReceipt> Origin;
};

struct PeriodicBuffCast
{
    std::weak_ptr<CoAAbilityPractice::CastReceipt> Action;
    std::vector<CapturedBuffOrigin> Buffs;
    std::uint64_t AwardedBits = 0;
    bool PeriodicObserved = false;

    bool MatchesOrigin(std::uint64_t bit, std::shared_ptr<CoAAbilityPractice::CastReceipt> const& origin) const
    {
        return origin && std::any_of(Buffs.begin(), Buffs.end(), [&origin, bit](auto const& buff)
        {
            return buff.Bit == bit && buff.Origin.lock() == origin;
        });
    }

    bool ObservePeriodic()
    {
        return !std::exchange(PeriodicObserved, true);
    }
};

class BuffCastLedger
{
public:
    static constexpr std::size_t MaximumCasts = 256;

    PeriodicBuffCast* Find(std::shared_ptr<CoAAbilityPractice::CastReceipt> const& action)
    {
        if (!action)
            return nullptr;
        auto const found = std::find_if(Casts.begin(), Casts.end(), [&action](auto const& cast)
        {
            return cast.Action.lock() == action;
        });
        return found == Casts.end() ? nullptr : &*found;
    }

    bool Capture(std::shared_ptr<CoAAbilityPractice::CastReceipt> const& action,
        std::vector<CapturedBuffOrigin> buffs)
    {
        std::erase_if(Casts, [](auto const& cast) { return cast.Action.expired(); });
        if (!action || buffs.empty() || Find(action) || Casts.size() >= MaximumCasts)
            return false;
        Casts.push_back({ action, std::move(buffs) });
        return true;
    }

    void Clear()
    {
        Casts.clear();
    }

private:
    std::vector<PeriodicBuffCast> Casts;
};
}

#endif
