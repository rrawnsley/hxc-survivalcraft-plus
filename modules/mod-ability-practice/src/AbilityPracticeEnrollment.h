#ifndef ABILITY_PRACTICE_ENROLLMENT_H
#define ABILITY_PRACTICE_ENROLLMENT_H

#include <charconv>
#include <cstdint>
#include <memory>
#include <string_view>
#include <unordered_set>

namespace AbilityPractice
{
struct CharacterEnrollment
{
    std::unordered_set<std::uint64_t> Guids;
    std::unordered_set<std::uint64_t> NewCharacterClasses;
    std::uint32_t NewCharacterMinimumGuid = 0;

    bool empty() const
    {
        return Guids.empty() && NewCharacterClasses.empty();
    }

    std::size_t size() const
    {
        return Guids.size();
    }

    bool Matches(std::uint64_t guid, std::uint32_t classId) const
    {
        return Guids.contains(guid) || (NewCharacterMinimumGuid && guid >= NewCharacterMinimumGuid &&
            guid <= UINT32_MAX && NewCharacterClasses.contains(classId));
    }
};

inline bool ParseEnrollmentIds(std::string_view setting, std::unordered_set<std::uint64_t>& result)
{
    if (setting.size() > 4096)
        return false;
    while (!setting.empty())
    {
        std::size_t const delimiter = setting.find(',');
        std::string_view token = setting.substr(0, delimiter);
        std::size_t const first = token.find_first_not_of(" \t");
        if (first == std::string_view::npos)
            return false;
        token = token.substr(first, token.find_last_not_of(" \t") - first + 1);
        std::uint32_t value = 0;
        auto const parsed = std::from_chars(token.data(), token.data() + token.size(), value);
        if (parsed.ec != std::errc{} || parsed.ptr != token.data() + token.size() || !value ||
            !result.insert(value).second || result.size() > 128)
            return false;
        if (delimiter == std::string_view::npos)
            break;
        setting.remove_prefix(delimiter + 1);
        if (setting.empty())
            return false;
    }
    return true;
}

inline std::shared_ptr<CharacterEnrollment const> ParseCharacterEnrollment(std::string_view characters,
    std::string_view classes = {}, std::string_view minimumGuid = "0")
{
    auto selection = std::make_shared<CharacterEnrollment>();
    if (!ParseEnrollmentIds(characters, selection->Guids) ||
        !ParseEnrollmentIds(classes, selection->NewCharacterClasses))
        return {};
    for (auto const classId : selection->NewCharacterClasses)
        if (classId < 12 || classId > 32)
            return {};
    auto const parsed = std::from_chars(minimumGuid.data(), minimumGuid.data() + minimumGuid.size(),
        selection->NewCharacterMinimumGuid);
    if (parsed.ec != std::errc{} || parsed.ptr != minimumGuid.data() + minimumGuid.size() ||
        selection->NewCharacterClasses.empty() != (selection->NewCharacterMinimumGuid == 0))
        return {};
    return selection;
}
}

#endif
