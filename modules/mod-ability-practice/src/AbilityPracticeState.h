#ifndef ABILITY_PRACTICE_STATE_H
#define ABILITY_PRACTICE_STATE_H

#include "AbilityPracticeProgression.h"

#include <optional>

namespace AbilityPractice
{
struct SaveTicket
{
    std::uint64_t Session;
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    std::uint64_t Revision;
    std::uint64_t Attempt;

    bool operator==(SaveTicket const&) const = default;
};

struct SaveSnapshot
{
    SaveTicket Ticket;
    std::uint32_t DefinitionVersion;
    Progress State;
};

class ProgressState
{
public:
    ProgressState(std::uint64_t session, std::uint32_t classId, std::uint32_t abilityId,
        std::uint32_t definitionVersion) :
        _session(session), _classId(classId), _abilityId(abilityId), _definitionVersion(definitionVersion) { }
    ProgressState(ProgressState const&) = delete;
    ProgressState& operator=(ProgressState const&) = delete;
    ProgressState(ProgressState&&) = delete;
    ProgressState& operator=(ProgressState&&) = delete;

    bool Initialize(TrainingPolicy policy, Progress loaded, bool requiresSave)
    {
        if (_revision || !_session || !_classId || !_abilityId || !_definitionVersion ||
            !ValidProgress(policy, loaded))
            return false;
        _progress = loaded;
        _revision = 1;
        _savedRevision = requiresSave ? 0 : 1;
        return true;
    }

    bool Replace(TrainingPolicy policy, Progress next)
    {
        if (!_revision || !ValidProgress(policy, next))
            return false;
        if (_progress.Proficiency == next.Proficiency && _progress.Points == next.Points)
            return true;
        if (_revision == std::numeric_limits<std::uint64_t>::max())
            return false;
        _progress = next;
        ++_revision;
        return true;
    }

    Award Apply(TrainingPolicy policy, std::uint32_t cap)
    {
        if (!_revision)
            return { AwardStatus::Invalid, _progress, 0 };
        Award const award = ApplyQualifyingUse(policy, _progress, cap);
        if (award.Status == AwardStatus::Applied && !Replace(policy, award.State))
            return { AwardStatus::Invalid, _progress, 0 };
        return award;
    }

    std::optional<SaveSnapshot> BeginSave()
    {
        if (!Dirty() || _inFlight || _attempt == std::numeric_limits<std::uint64_t>::max())
            return std::nullopt;
        SaveSnapshot const snapshot{
            { _session, _classId, _abilityId, _revision, ++_attempt }, _definitionVersion, _progress };
        _inFlight = snapshot.Ticket;
        return snapshot;
    }

    bool CompleteSave(SaveTicket ticket, bool succeeded)
    {
        if (!_inFlight || ticket != *_inFlight)
            return false;
        if (succeeded)
            _savedRevision = ticket.Revision;
        _inFlight.reset();
        return true;
    }

    bool Ready() const { return _revision != 0; }
    bool Dirty() const { return _revision > _savedRevision; }
    Progress Get() const { return _progress; }

private:
    std::uint64_t _session;
    std::uint32_t _classId;
    std::uint32_t _abilityId;
    std::uint32_t _definitionVersion;
    Progress _progress;
    std::uint64_t _revision = 0;
    std::uint64_t _savedRevision = 0;
    std::uint64_t _attempt = 0;
    std::optional<SaveTicket> _inFlight;
};
}

#endif
