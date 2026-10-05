#ifndef ABILITY_PRACTICE_ACTIONS_H
#define ABILITY_PRACTICE_ACTIONS_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <limits>

namespace AbilityPractice
{
struct ActionToken
{
    std::uint64_t Session = 0;
    std::uint64_t Sequence = 0;

    bool operator==(ActionToken const&) const = default;
};

enum class ActionResult
{
    Invalid,
    Unqualified,
    Award,
    AlreadyAwarded
};

template<std::size_t Capacity>
class ActionLedger
{
public:
    explicit ActionLedger(std::uint64_t session) : _session(session) { }
    ActionLedger(ActionLedger const&) = delete;
    ActionLedger& operator=(ActionLedger const&) = delete;
    ActionLedger(ActionLedger&&) = delete;
    ActionLedger& operator=(ActionLedger&&) = delete;

    ActionToken Begin(std::uint32_t abilityId)
    {
        if (!_session || !abilityId || _sequence == std::numeric_limits<std::uint64_t>::max())
            return {};
        for (Entry& entry : _entries)
        {
            if (entry.Token.Sequence)
                continue;
            entry = { { _session, ++_sequence }, abilityId, false };
            ++_active;
            return entry.Token;
        }
        return {};
    }

    ActionResult Consume(ActionToken token, std::uint32_t abilityId, bool qualifyingOutcome)
    {
        if (!token.Sequence || token.Session != _session || !abilityId)
            return ActionResult::Invalid;
        for (Entry& entry : _entries)
        {
            if (entry.Token != token || entry.AbilityId != abilityId)
                continue;
            if (entry.Awarded)
                return ActionResult::AlreadyAwarded;
            if (!qualifyingOutcome)
                return ActionResult::Unqualified;
            entry.Awarded = true;
            return ActionResult::Award;
        }
        return ActionResult::Invalid;
    }

    bool End(ActionToken token)
    {
        if (!token.Sequence || token.Session != _session)
            return false;
        for (Entry& entry : _entries)
        {
            if (entry.Token != token)
                continue;
            entry = {};
            --_active;
            return true;
        }
        return false;
    }

    std::size_t Active() const { return _active; }

private:
    struct Entry
    {
        ActionToken Token;
        std::uint32_t AbilityId = 0;
        bool Awarded = false;
    };

    std::array<Entry, Capacity> _entries{};
    std::uint64_t _session = 0;
    std::uint64_t _sequence = 0;
    std::size_t _active = 0;
};
}

#endif
