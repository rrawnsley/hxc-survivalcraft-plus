DELETE FROM `coa_challenge_definition` WHERE `id` IN (9001, 9002);
INSERT INTO `coa_challenge_definition` (`id`, `name`, `icon`, `levelCount`, `isTrial`, `exclusiveGroup`, `noRewards`, `noResurrect`, `lives`, `rules`, `conditions`, `objectives`) VALUES
(9001, 'Old School', 'INV_Misc_Book_09', 1, 1, 1, 1, 0, 0, 'CHALLENGE_RULES_TYPE_STRICT_CHALLENGE_RESTRICTED_TAPPING', '', ''),
(9002, 'Old School - Hardcore', 'Achievement_BG_KillFlagCarriers_grabFlag_CapIt', 1, 1, 1, 1, 0, 1, 'CHALLENGE_RULES_TYPE_STRICT_CHALLENGE_RESTRICTED_TAPPING', '', 'CHALLENGE_REQUIREMENT_TYPE_COMPLETE_WITHOUT_DEATH:1/0/0');
