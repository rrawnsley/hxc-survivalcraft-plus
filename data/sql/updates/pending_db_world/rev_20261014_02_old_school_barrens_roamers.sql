INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, `name`, `subname`,
    `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    996704, 0, 0, 0,
    0, 0, 'Cacklemaw', 'Old School roaming threat',
    `IconName`, 0, 24, 24,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    4, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 996704, 0,
    `skinloot`, `PetSpellDataId`, `VehicleId`, 48,
    120, `AIName`, `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 5829
ON DUPLICATE KEY UPDATE
    `minlevel` = VALUES(`minlevel`), `maxlevel` = VALUES(`maxlevel`), `rank` = VALUES(`rank`), `lootid` = VALUES(`lootid`),
    `KillCredit1` = VALUES(`KillCredit1`), `KillCredit2` = VALUES(`KillCredit2`), `npcflag` = VALUES(`npcflag`), `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `HealthModifier` = VALUES(`HealthModifier`), `DamageModifier` = VALUES(`DamageModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`), `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`), `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`),
    `pickpocketloot` = VALUES(`pickpocketloot`), `name` = VALUES(`name`), `subname` = VALUES(`subname`), `ScriptName` = VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996704;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 996704, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 5829;

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`,
    `name`, `displayid`, `Quality`, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
    `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`,
    `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`,
    `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`,
    `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`,
    `bonding`, `description`, `PageText`, `LanguageID`,
    `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`,
    `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`,
    `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`)
SELECT
    996704, `class`, `subclass`, `SoundOverrideSubclass`,
    'Cacklemaw Shroud', `displayid`, `Quality`, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
    `requiredhonorrank`, `RequiredCityRank`, 0, 0,
    1, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`,
    `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`,
    `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`,
    `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`,
    2, `description`, `PageText`, `LanguageID`,
    `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, 0, 0, `block`,
    `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`,
    `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 4713
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`), `bonding` = VALUES(`bonding`), `maxcount` = VALUES(`maxcount`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`), `RequiredReputationRank` = VALUES(`RequiredReputationRank`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996704;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(996704, 996704, 0, 25, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9996704;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`,
    `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`,
    `curmana`, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`)
SELECT
    9996704, 996704, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    1800, 0, 0, 0,
    0, 2, `npcflag`, `unit_flags`,
    `dynamicflags`, '', `VerifiedBuild`, `CreateObject`,
    'Old School Barrens roaming encounter'
FROM `creature` WHERE `guid` = 20409;

DELETE FROM `creature_addon` WHERE `guid` = 9996704;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
SELECT 9996704, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_addon` WHERE `guid` = 20409;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996704 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`)
SELECT
    996704, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, 'Cacklemaw - Native combat abilities'
FROM `smart_scripts` WHERE `entryorguid` = 5829 AND `source_type` = 0;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, `name`, `subname`,
    `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    996705, 0, 0, 0,
    0, 0, 'Sablemane', 'Old School roaming threat',
    `IconName`, 0, 28, 28,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    4, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 996705, 0,
    `skinloot`, `PetSpellDataId`, `VehicleId`, 56,
    140, `AIName`, `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 5828
ON DUPLICATE KEY UPDATE
    `minlevel` = VALUES(`minlevel`), `maxlevel` = VALUES(`maxlevel`), `rank` = VALUES(`rank`), `lootid` = VALUES(`lootid`),
    `KillCredit1` = VALUES(`KillCredit1`), `KillCredit2` = VALUES(`KillCredit2`), `npcflag` = VALUES(`npcflag`), `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `HealthModifier` = VALUES(`HealthModifier`), `DamageModifier` = VALUES(`DamageModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`), `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`), `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`),
    `pickpocketloot` = VALUES(`pickpocketloot`), `name` = VALUES(`name`), `subname` = VALUES(`subname`), `ScriptName` = VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996705;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 996705, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 5828;

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`,
    `name`, `displayid`, `Quality`, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
    `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`,
    `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`,
    `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`,
    `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`,
    `bonding`, `description`, `PageText`, `LanguageID`,
    `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`,
    `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`,
    `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`)
SELECT
    996705, `class`, `subclass`, `SoundOverrideSubclass`,
    'Sablemane Hide Harness', `displayid`, `Quality`, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
    `requiredhonorrank`, `RequiredCityRank`, 0, 0,
    1, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`,
    `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`,
    `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`,
    `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`,
    2, `description`, `PageText`, `LanguageID`,
    `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, 0, 0, `block`,
    `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`,
    `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 4455
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`), `bonding` = VALUES(`bonding`), `maxcount` = VALUES(`maxcount`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`), `RequiredReputationRank` = VALUES(`RequiredReputationRank`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996705;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(996705, 996705, 0, 25, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9996705;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`,
    `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`,
    `curmana`, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`)
SELECT
    9996705, 996705, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    1800, 0, 0, 0,
    0, 2, `npcflag`, `unit_flags`,
    `dynamicflags`, '', `VerifiedBuild`, `CreateObject`,
    'Old School Barrens roaming encounter'
FROM `creature` WHERE `guid` = 65607;

DELETE FROM `creature_addon` WHERE `guid` = 9996705;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
SELECT 9996705, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_addon` WHERE `guid` = 20409;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996705 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`)
SELECT
    996705, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, 'Sablemane - Native combat abilities'
FROM `smart_scripts` WHERE `entryorguid` = 5828 AND `source_type` = 0;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, `name`, `subname`,
    `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    996706, 0, 0, 0,
    0, 0, 'Thunderhide', 'Old School roaming threat',
    `IconName`, 0, 34, 34,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 996706, 0,
    `skinloot`, `PetSpellDataId`, `VehicleId`, 68,
    170, `AIName`, `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3474
ON DUPLICATE KEY UPDATE
    `minlevel` = VALUES(`minlevel`), `maxlevel` = VALUES(`maxlevel`), `rank` = VALUES(`rank`), `lootid` = VALUES(`lootid`),
    `KillCredit1` = VALUES(`KillCredit1`), `KillCredit2` = VALUES(`KillCredit2`), `npcflag` = VALUES(`npcflag`), `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `HealthModifier` = VALUES(`HealthModifier`), `DamageModifier` = VALUES(`DamageModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`), `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`), `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`),
    `pickpocketloot` = VALUES(`pickpocketloot`), `name` = VALUES(`name`), `subname` = VALUES(`subname`), `ScriptName` = VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996706;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 996706, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3474;

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`,
    `name`, `displayid`, `Quality`, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
    `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`,
    `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`,
    `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`,
    `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`,
    `bonding`, `description`, `PageText`, `LanguageID`,
    `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`,
    `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`,
    `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`)
SELECT
    996706, `class`, `subclass`, `SoundOverrideSubclass`,
    'Thunderhide Signet', `displayid`, `Quality`, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
    `requiredhonorrank`, `RequiredCityRank`, 0, 0,
    1, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`,
    `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`,
    `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`,
    `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`,
    2, `description`, `PageText`, `LanguageID`,
    `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, 0, 0, `block`,
    `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`,
    `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 20827
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`), `bonding` = VALUES(`bonding`), `maxcount` = VALUES(`maxcount`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`), `RequiredReputationRank` = VALUES(`RequiredReputationRank`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996706;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(996706, 996706, 0, 25, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9996706;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`,
    `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`,
    `curmana`, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`)
SELECT
    9996706, 996706, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    1800, 0, 0, 0,
    0, 2, `npcflag`, `unit_flags`,
    `dynamicflags`, '', `VerifiedBuild`, `CreateObject`,
    'Old School Barrens roaming encounter'
FROM `creature` WHERE `guid` = 15083;

DELETE FROM `creature_addon` WHERE `guid` = 9996706;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
SELECT 9996706, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_addon` WHERE `guid` = 15083;

UPDATE `creature` AS `c`
JOIN `creature_addon` AS `a` ON `a`.`guid` = `c`.`guid`
JOIN `waypoint_data` AS `w` ON `w`.`id` = `a`.`path_id` AND `w`.`point` =
    CASE `c`.`guid`
        WHEN 9996701 THEN 40
        WHEN 9996702 THEN 35
        WHEN 9996703 THEN 52
        WHEN 9996704 THEN 10
        WHEN 9996705 THEN 30
        WHEN 9996706 THEN 27
    END
SET `c`.`position_x` = `w`.`position_x`, `c`.`position_y` = `w`.`position_y`, `c`.`position_z` = `w`.`position_z`,
    `c`.`currentwaypoint` = `w`.`point` - 1
WHERE `c`.`guid` IN (9996701, 9996702, 9996703, 9996704, 9996705, 9996706);
