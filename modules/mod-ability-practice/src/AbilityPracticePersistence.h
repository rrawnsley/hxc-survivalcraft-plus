#ifndef ABILITY_PRACTICE_PERSISTENCE_H
#define ABILITY_PRACTICE_PERSISTENCE_H

#include "AbilityPracticeCatalog.h"

#include <array>
#include <optional>
#include <string>

namespace AbilityPractice
{
inline constexpr std::uint32_t StorageSchemaVersion = 1;
inline constexpr std::uint32_t LearnedRankMigrationVersion = 1;
inline constexpr std::size_t StoredFieldCount = 5;

enum class LoadStatus
{
    Invalid,
    Missing,
    Loaded,
    UnsupportedSchema,
    DefinitionMismatch,
    UnsupportedMigration
};

struct StoredProgress
{
    std::uint32_t DefinitionVersion = 0;
    std::uint32_t MigrationVersion = 0;
    Progress State;
};

struct LoadedProgress
{
    LoadStatus Status = LoadStatus::Invalid;
    StoredProgress Record;
};

inline std::string StorageSource(std::uint32_t classId, std::uint32_t abilityId)
{
    if (!classId || classId > 255 || !abilityId)
        return {};
    return "core.hxc.ability_practice." + std::to_string(classId) + "." + std::to_string(abilityId);
}

inline LoadedProgress DecodeStoredProgress(TrainingPolicy policy, std::uint32_t definitionVersion,
    std::span<std::uint32_t const> fields, bool present)
{
    if (!definitionVersion || !ValidPolicy(policy))
        return {};
    if (!present)
        return { LoadStatus::Missing, { definitionVersion, 0, {} } };
    if (fields.size() != StoredFieldCount)
        return {};
    if (fields[0] != StorageSchemaVersion)
        return { LoadStatus::UnsupportedSchema, {} };
    if (fields[1] != definitionVersion)
        return { LoadStatus::DefinitionMismatch, {} };
    if (fields[2] > LearnedRankMigrationVersion)
        return { LoadStatus::UnsupportedMigration, {} };
    Progress const progress{ fields[3], fields[4] };
    if (!ValidProgress(policy, progress))
        return {};
    return { LoadStatus::Loaded, { fields[1], fields[2], progress } };
}

inline std::optional<std::array<std::uint32_t, StoredFieldCount>> EncodeStoredProgress(
    TrainingPolicy policy, StoredProgress record)
{
    if (!record.DefinitionVersion || record.MigrationVersion > LearnedRankMigrationVersion ||
        !ValidProgress(policy, record.State))
        return std::nullopt;
    return std::array<std::uint32_t, StoredFieldCount>{ StorageSchemaVersion, record.DefinitionVersion,
        record.MigrationVersion, record.State.Proficiency, static_cast<std::uint32_t>(record.State.Points) };
}

inline std::optional<StoredProgress> RebaseStoredProgress(TrainingPolicy previousPolicy,
    TrainingPolicy nextPolicy, std::uint32_t nextDefinitionVersion, StoredProgress previous,
    std::uint32_t minimumProficiency = 0)
{
    if (!EncodeStoredProgress(previousPolicy, previous) || !ValidPolicy(nextPolicy) ||
        nextDefinitionVersion <= previous.DefinitionVersion)
        return std::nullopt;
    std::uint32_t const previousCost = previousPolicy.Bands[
        Detail::BandIndex(previousPolicy, previous.State.Proficiency)].PointsPerLevel;
    std::uint32_t const nextProficiency = std::max(previous.State.Proficiency, minimumProficiency);
    std::uint32_t const nextCost = nextPolicy.Bands[
        Detail::BandIndex(nextPolicy, nextProficiency)].PointsPerLevel;
    std::uint64_t const scaledPoints = previous.State.Points * nextCost;
    if (scaledPoints % previousCost)
        return std::nullopt;
    StoredProgress next = previous;
    next.DefinitionVersion = nextDefinitionVersion;
    next.State.Proficiency = nextProficiency;
    next.State.Points = scaledPoints / previousCost;
    return EncodeStoredProgress(nextPolicy, next) ? std::optional<StoredProgress>{ next } : std::nullopt;
}

inline std::optional<StoredProgress> MigrateLearnedRanks(AbilityDefinition const& ability,
    TrainingPolicy policy, LoadedProgress loaded, std::span<std::uint32_t const> learnedSpells)
{
    if ((loaded.Status != LoadStatus::Missing && loaded.Status != LoadStatus::Loaded) ||
        ValidateDefinition(ability) != CatalogError::None || ability.Kind == AbilityKind::Fixed ||
        !EncodeStoredProgress(policy, loaded.Record))
        return std::nullopt;
    StoredProgress record = loaded.Record;
    if (record.MigrationVersion < LearnedRankMigrationVersion)
    {
        Progress const seeded = SeedLearnedRanks(ability, record.State, learnedSpells);
        std::uint32_t const previousCost = policy.Bands[
            Detail::BandIndex(policy, record.State.Proficiency)].PointsPerLevel;
        std::uint32_t const nextCost = policy.Bands[
            Detail::BandIndex(policy, seeded.Proficiency)].PointsPerLevel;
        std::uint64_t const scaledPoints = record.State.Points * nextCost;
        if (scaledPoints % previousCost)
            return std::nullopt;
        record.State = { seeded.Proficiency, scaledPoints / previousCost };
        record.MigrationVersion = LearnedRankMigrationVersion;
    }
    return record;
}

template<typename PlayerType>
LoadedProgress ReadPlayerProgress(PlayerType const& player, std::uint32_t classId,
    std::uint32_t abilityId, TrainingPolicy policy, std::uint32_t definitionVersion)
{
    std::string const source = StorageSource(classId, abilityId);
    if (source.empty())
        return {};
    auto const* settings = player.FindPlayerSettings(source);
    if (!settings)
        return DecodeStoredProgress(policy, definitionVersion, {}, false);
    if (settings->size() != StoredFieldCount)
        return {};
    std::array<std::uint32_t, StoredFieldCount> fields;
    for (std::size_t index = 0; index < fields.size(); ++index)
        fields[index] = (*settings)[index].value;
    return DecodeStoredProgress(policy, definitionVersion, fields, true);
}

template<typename PlayerType>
bool CacheRebasedPlayerProgress(PlayerType& player, std::uint32_t classId, std::uint32_t abilityId,
    TrainingPolicy previousPolicy, TrainingPolicy nextPolicy, std::uint32_t nextDefinitionVersion,
    StoredProgress expectedPrevious, std::uint32_t minimumProficiency = 0)
{
    std::string const source = StorageSource(classId, abilityId);
    auto const next = RebaseStoredProgress(previousPolicy, nextPolicy, nextDefinitionVersion,
        expectedPrevious, minimumProficiency);
    if (source.empty() || !next)
        return false;
    LoadedProgress const existing = ReadPlayerProgress(player, classId, abilityId,
        previousPolicy, expectedPrevious.DefinitionVersion);
    if (existing.Status != LoadStatus::Loaded ||
        existing.Record.MigrationVersion != expectedPrevious.MigrationVersion ||
        existing.Record.State.Proficiency != expectedPrevious.State.Proficiency ||
        existing.Record.State.Points != expectedPrevious.State.Points)
        return false;
    auto const fields = EncodeStoredProgress(nextPolicy, *next);
    if (!fields)
        return false;
    for (std::size_t index = 0; index < fields->size(); ++index)
        player.UpdatePlayerSetting(source, static_cast<std::uint32_t>(index), (*fields)[index]);
    return true;
}

template<typename PlayerType>
bool CachePlayerProgress(PlayerType& player, std::uint32_t classId, std::uint32_t abilityId,
    TrainingPolicy policy, StoredProgress record)
{
    std::string const source = StorageSource(classId, abilityId);
    auto const fields = EncodeStoredProgress(policy, record);
    if (source.empty() || !fields)
        return false;
    LoadedProgress const existing = ReadPlayerProgress(player, classId, abilityId, policy, record.DefinitionVersion);
    if (existing.Status != LoadStatus::Missing && existing.Status != LoadStatus::Loaded)
        return false;
    if (existing.Status == LoadStatus::Loaded &&
        (record.MigrationVersion < existing.Record.MigrationVersion ||
            record.State.Proficiency < existing.Record.State.Proficiency ||
            (record.State.Proficiency == existing.Record.State.Proficiency &&
                record.State.Points < existing.Record.State.Points)))
        return false;
    for (std::size_t index = 0; index < fields->size(); ++index)
        player.UpdatePlayerSetting(source, static_cast<std::uint32_t>(index), (*fields)[index]);
    return true;
}
}

#endif
