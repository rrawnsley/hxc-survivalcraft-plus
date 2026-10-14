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
    996866, 0, 0, 0,
    0, 0, 'Duskrunner Ghostpaw', 'Old School named encounter',
    `IconName`, 0, 21, 21,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    4, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 996866, 0,
    `skinloot`, `PetSpellDataId`, `VehicleId`, 42,
    105, `AIName`, `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3823
ON DUPLICATE KEY UPDATE
    `minlevel` = VALUES(`minlevel`), `maxlevel` = VALUES(`maxlevel`), `rank` = VALUES(`rank`), `lootid` =
        VALUES(`lootid`),
    `KillCredit1` = VALUES(`KillCredit1`), `KillCredit2` = VALUES(`KillCredit2`), `npcflag` = VALUES(`npcflag`),
        `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `HealthModifier` = VALUES(`HealthModifier`), `DamageModifier` = VALUES(`DamageModifier`), `ExperienceModifier` =
        VALUES(`ExperienceModifier`), `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`), `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `mingold`
        = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`),
    `pickpocketloot` = VALUES(`pickpocketloot`), `name` = VALUES(`name`), `subname` = VALUES(`subname`), `ScriptName` =
        VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996866;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx` , `CreatureDisplayID` , `DisplayScale` , `Probability` ,
    `VerifiedBuild` )
SELECT 996866, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3823 AND `Idx` = 0;

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
    996866, `class`, `subclass`, `SoundOverrideSubclass`,
    'Duskrunner Hillman Mantle', `displayid`, `Quality`, `Flags`,
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
FROM `item_template` WHERE `entry` = 4251
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`), `bonding` = VALUES(`bonding`), `maxcount` = VALUES(`maxcount`), `RandomProperty` =
        VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
        `RequiredReputationRank` = VALUES(`RequiredReputationRank`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996866;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(996866, 996866, 0, 25, 0, 1, 0, 1, 1),
(996866, 2319, 0, 100, 0, 1, 0, 1, 2);

DELETE FROM `creature` WHERE `guid` = 9996866;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`,
    `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`,
    `curmana`, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`)
SELECT
    9996866, 996866, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    1800, `wander_distance`, 0, 0,
    0, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, '', `VerifiedBuild`, `CreateObject`,
    'Old School named encounter'
FROM `creature` WHERE `guid` = 34986;

DELETE FROM `creature_addon` WHERE `guid` = 9996866;
INSERT INTO `creature_addon` (`guid`, `path_id` , `mount` , `bytes1` , `bytes2` , `emote` , `visibilityDistanceType` ,
    `auras` )
SELECT 9996866, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_addon` WHERE `guid` = 34986;

DELETE FROM `creature_template_addon` WHERE `entry` = 996866;
INSERT INTO `creature_template_addon` (
    `entry`, `path_id`, `mount`, `bytes1`,
    `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
SELECT
    996866, `path_id`, `mount`, `bytes1`,
    `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_template_addon` WHERE `entry` = 3823;

DELETE FROM `creature_text` WHERE `CreatureID` = 996866;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`,
    `Type`, `Language`, `Probability`, `Emote`,
    `Duration`, `Sound`, `BroadcastTextId`, `TextRange`,
    `comment`)
SELECT
    996866, `GroupID`, `ID`, `Text`,
    `Type`, `Language`, `Probability`, `Emote`,
    `Duration`, `Sound`, `BroadcastTextId`, `TextRange`,
    'Duskrunner Ghostpaw'
FROM `creature_text` WHERE `CreatureID` = 3823;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996866 AND `source_type` = 0;
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
    996866, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, 'Duskrunner Ghostpaw'
FROM `smart_scripts` WHERE `entryorguid` = 3823 AND `source_type` = 0 AND `id` < 100;

UPDATE `creature` AS `c`
JOIN `creature_addon` AS `a` ON `a`.`guid` = `c`.`guid`
JOIN `waypoint_data` AS `w` ON `w`.`id` = `a`.`path_id` AND `w`.`point` = 11
SET `c`.`position_x` = `w`.`position_x`, `c`.`position_y` = `w`.`position_y`, `c`.`position_z` = `w`.`position_z`,
    `c`.`currentwaypoint` = `w`.`point` - 1
WHERE `c`.`guid` = 9996866;
UPDATE `creature_template` SET `HealthModifier` = 1.25, `DamageModifier` = 1.10
WHERE `entry` = 996866;
UPDATE `creature` SET `spawntimesecs` = 600
WHERE `guid` = 9996866;

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
    996867, 0, 0, 0,
    0, 0, 'Sorceress Vaesh Wrathtail', 'Old School named encounter',
    `IconName`, 0, 20, 20,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    4, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 996867, 0,
    `skinloot`, `PetSpellDataId`, `VehicleId`, 40,
    100, `AIName`, `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3717
ON DUPLICATE KEY UPDATE
    `minlevel` = VALUES(`minlevel`), `maxlevel` = VALUES(`maxlevel`), `rank` = VALUES(`rank`), `lootid` =
        VALUES(`lootid`),
    `KillCredit1` = VALUES(`KillCredit1`), `KillCredit2` = VALUES(`KillCredit2`), `npcflag` = VALUES(`npcflag`),
        `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `HealthModifier` = VALUES(`HealthModifier`), `DamageModifier` = VALUES(`DamageModifier`), `ExperienceModifier` =
        VALUES(`ExperienceModifier`), `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`), `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `mingold`
        = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`),
    `pickpocketloot` = VALUES(`pickpocketloot`), `name` = VALUES(`name`), `subname` = VALUES(`subname`), `ScriptName` =
        VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996867;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx` , `CreatureDisplayID` , `DisplayScale` , `Probability` ,
    `VerifiedBuild` )
SELECT 996867, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3717 AND `Idx` = 0;

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
    996867, `class`, `subclass`, `SoundOverrideSubclass`,
    'Vaesh Mystic Sphere', `displayid`, `Quality`, `Flags`,
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
FROM `item_template` WHERE `entry` = 15946
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`), `bonding` = VALUES(`bonding`), `maxcount` = VALUES(`maxcount`), `RandomProperty` =
        VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
        `RequiredReputationRank` = VALUES(`RequiredReputationRank`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996867;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(996867, 996867, 0, 25, 0, 1, 0, 1, 1),
(996867, 2592, 0, 100, 0, 1, 0, 1, 2);

DELETE FROM `creature` WHERE `guid` = 9996867;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`,
    `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`,
    `curmana`, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`)
SELECT
    9996867, 996867, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    1800, `wander_distance`, 0, 0,
    0, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, '', `VerifiedBuild`, `CreateObject`,
    'Old School named encounter'
FROM `creature` WHERE `guid` = 32797;

DELETE FROM `creature_addon` WHERE `guid` = 9996867;
INSERT INTO `creature_addon` (`guid`, `path_id` , `mount` , `bytes1` , `bytes2` , `emote` , `visibilityDistanceType` ,
    `auras` )
SELECT 9996867, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_addon` WHERE `guid` = 32797;

DELETE FROM `creature_template_addon` WHERE `entry` = 996867;
INSERT INTO `creature_template_addon` (
    `entry`, `path_id`, `mount`, `bytes1`,
    `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
SELECT
    996867, `path_id`, `mount`, `bytes1`,
    `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_template_addon` WHERE `entry` = 3717;

DELETE FROM `creature_text` WHERE `CreatureID` = 996867;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`,
    `Type`, `Language`, `Probability`, `Emote`,
    `Duration`, `Sound`, `BroadcastTextId`, `TextRange`,
    `comment`)
SELECT
    996867, `GroupID`, `ID`, `Text`,
    `Type`, `Language`, `Probability`, `Emote`,
    `Duration`, `Sound`, `BroadcastTextId`, `TextRange`,
    'Sorceress Vaesh Wrathtail'
FROM `creature_text` WHERE `CreatureID` = 3717;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996867 AND `source_type` = 0;
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
    996867, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, 'Sorceress Vaesh Wrathtail'
FROM `smart_scripts` WHERE `entryorguid` = 3717 AND `source_type` = 0 AND `id` < 100;

UPDATE `creature` AS `c`
JOIN `creature_addon` AS `a` ON `a`.`guid` = `c`.`guid`
JOIN `waypoint_data` AS `w` ON `w`.`id` = `a`.`path_id` AND `w`.`point` = 9
SET `c`.`position_x` = `w`.`position_x`, `c`.`position_y` = `w`.`position_y`, `c`.`position_z` = `w`.`position_z`,
    `c`.`currentwaypoint` = `w`.`point` - 1
WHERE `c`.`guid` = 9996867;
UPDATE `creature_template` SET `HealthModifier` = 1.25, `DamageModifier` = 1.10
WHERE `entry` = 996867;
UPDATE `creature` SET `spawntimesecs` = 600
WHERE `guid` = 9996867;

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
    996868, 0, 0, 0,
    0, 0, 'Lady Soryss of the Shoals', 'Old School named encounter',
    `IconName`, 0, 23, 23,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    4, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 996868, 0,
    `skinloot`, `PetSpellDataId`, `VehicleId`, 46,
    115, `AIName`, `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 10559
ON DUPLICATE KEY UPDATE
    `minlevel` = VALUES(`minlevel`), `maxlevel` = VALUES(`maxlevel`), `rank` = VALUES(`rank`), `lootid` =
        VALUES(`lootid`),
    `KillCredit1` = VALUES(`KillCredit1`), `KillCredit2` = VALUES(`KillCredit2`), `npcflag` = VALUES(`npcflag`),
        `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `HealthModifier` = VALUES(`HealthModifier`), `DamageModifier` = VALUES(`DamageModifier`), `ExperienceModifier` =
        VALUES(`ExperienceModifier`), `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`), `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `mingold`
        = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`),
    `pickpocketloot` = VALUES(`pickpocketloot`), `name` = VALUES(`name`), `subname` = VALUES(`subname`), `ScriptName` =
        VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996868;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx` , `CreatureDisplayID` , `DisplayScale` , `Probability` ,
    `VerifiedBuild` )
SELECT 996868, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 10559 AND `Idx` = 0;

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
    996868, `class`, `subclass`, `SoundOverrideSubclass`,
    'Soryss Woolen Mantle', `displayid`, `Quality`, `Flags`,
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
FROM `item_template` WHERE `entry` = 4315
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`), `bonding` = VALUES(`bonding`), `maxcount` = VALUES(`maxcount`), `RandomProperty` =
        VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
        `RequiredReputationRank` = VALUES(`RequiredReputationRank`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996868;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(996868, 996868, 0, 25, 0, 1, 0, 1, 1),
(996868, 2592, 0, 100, 0, 1, 0, 1, 2);

DELETE FROM `creature` WHERE `guid` = 9996868;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`,
    `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`,
    `curmana`, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`)
SELECT
    9996868, 996868, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    1800, `wander_distance`, 0, 0,
    0, `MovementType`, `npcflag`, `unit_flags`,
    `dynamicflags`, '', `VerifiedBuild`, `CreateObject`,
    'Old School named encounter'
FROM `creature` WHERE `guid` = 32384;

DELETE FROM `creature_addon` WHERE `guid` = 9996868;
INSERT INTO `creature_addon` (`guid`, `path_id` , `mount` , `bytes1` , `bytes2` , `emote` , `visibilityDistanceType` ,
    `auras` )
SELECT 9996868, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_addon` WHERE `guid` = 32384;

DELETE FROM `creature_template_addon` WHERE `entry` = 996868;
INSERT INTO `creature_template_addon` (
    `entry`, `path_id`, `mount`, `bytes1`,
    `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
SELECT
    996868, `path_id`, `mount`, `bytes1`,
    `bytes2`, `emote`, `visibilityDistanceType`, `auras`
FROM `creature_template_addon` WHERE `entry` = 10559;

DELETE FROM `creature_text` WHERE `CreatureID` = 996868;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`,
    `Type`, `Language`, `Probability`, `Emote`,
    `Duration`, `Sound`, `BroadcastTextId`, `TextRange`,
    `comment`)
SELECT
    996868, `GroupID`, `ID`, `Text`,
    `Type`, `Language`, `Probability`, `Emote`,
    `Duration`, `Sound`, `BroadcastTextId`, `TextRange`,
    'Lady Soryss of the Shoals'
FROM `creature_text` WHERE `CreatureID` = 10559;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996868 AND `source_type` = 0;
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
    996868, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, 'Lady Soryss of the Shoals'
FROM `smart_scripts` WHERE `entryorguid` = 10559 AND `source_type` = 0 AND `id` < 100;

UPDATE `creature` AS `c`
JOIN `creature_addon` AS `a` ON `a`.`guid` = `c`.`guid`
JOIN `waypoint_data` AS `w` ON `w`.`id` = `a`.`path_id` AND `w`.`point` = 52
SET `c`.`position_x` = `w`.`position_x`, `c`.`position_y` = `w`.`position_y`, `c`.`position_z` = `w`.`position_z`,
    `c`.`currentwaypoint` = `w`.`point` - 1
WHERE `c`.`guid` = 9996868;
UPDATE `creature_template` SET `HealthModifier` = 1.25, `DamageModifier` = 1.10
WHERE `entry` = 996868;
UPDATE `creature` SET `spawntimesecs` = 600
WHERE `guid` = 9996868;
