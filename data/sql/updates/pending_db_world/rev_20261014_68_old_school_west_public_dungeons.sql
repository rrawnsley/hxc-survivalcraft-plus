INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997000, 0, 0, 0, 0, 0, 'Mine Drudger', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 7, 7, `exp`, `faction`,
    0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997000, 0, `skinloot`, 0, 0, 21, 56, 'SmartAI', 0, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2976
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997000;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997000, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2976;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997000;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997000, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2976;

DELETE FROM `creature` WHERE `guid` = 9997100;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997100, 997000, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1922.62, -743.353, -2.62556, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26284;

DELETE FROM `creature_addon` WHERE `guid` = 9997100;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997100, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997000 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997000, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997001, 0, 0, 0, 0, 0, 'Mine Guard', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 7, 7, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 997001, 0, `skinloot`, 0, 0, 21, 56, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2977
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997001;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997001, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2977;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997001;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997001, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2977;

DELETE FROM `creature` WHERE `guid` = 9997101;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997101, 997001, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1933.98, -712.028, 3.65329, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26357;

DELETE FROM `creature_addon` WHERE `guid` = 9997101;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997101, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997001 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997001, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997002, 0, 0, 0, 0, 0, 'Mine Taskmaster', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 8, 8, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997002, 0, `skinloot`, 0, 0, 24, 64, 'SmartAI', 0, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2977
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997002;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997002, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2977;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997002;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997002, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2977;

DELETE FROM `creature` WHERE `guid` = 9997102;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997102, 997002, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1914.83, -723.258, 2.49843, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26358;

DELETE FROM `creature_addon` WHERE `guid` = 9997102;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997102, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997002 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997002, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997003, 0, 0, 0, 0, 0, 'Ore Cart Patrol', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 8, 8, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997003, 0, `skinloot`, 0, 0, 24, 64, 'SmartAI', 0, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2977
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997003;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997003, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2977;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997003;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997003, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2977;

DELETE FROM `creature` WHERE `guid` = 9997103;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997103, 997003, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1914.06, -674.479, -5.3324, 0, 360, 0, 0, 0, 0, 2, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26356;

DELETE FROM `creature_addon` WHERE `guid` = 9997103;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997103, 99971030, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99971030;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`,
    `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(
    99971030, 1, -1914.06, -674.479, -5.3324, 0, 0, 0, 0, 0, 0, 100, 0),
(
    99971030, 2, -1889.09, -715.831, -1.28166, 0, 0, 0, 0, 0, 0, 100, 0),
(
    99971030, 3, -1895.25, -694.292, -2.58544, 0, 0, 0, 0, 0, 0, 100, 0),
(
    99971030, 4, -1914.06, -674.479, -5.3324, 0, 0, 0, 0, 0, 0, 100, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997003 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997003, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997004, 0, 0, 0, 0, 0, 'Foreman Hark', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 8, 8, `exp`, `faction`,
    0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997004, 0, `skinloot`, 0, 0, 24, 64, 'SmartAI', 0, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2977
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997004;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997004, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2977;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997004;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997004, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2977;

DELETE FROM `creature` WHERE `guid` = 9997104;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997104, 997004, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1950.67, -682.458, -1.69813, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26269;

DELETE FROM `creature_addon` WHERE `guid` = 9997104;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997104, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997004;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997004, 0, 0, 'Foreman Hark signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Venture Co. mine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997004 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997004, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997004, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997005, 0, 0, 0, 0, 0, 'The Mine Breaker', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 8, 8, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997005, 0, `skinloot`, 0, 0, 24, 64, 'SmartAI', 0, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2977
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997005;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997005, `Idx`, `CreatureDisplayID`, 1.8, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2977;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997005;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997005, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2977;

DELETE FROM `creature` WHERE `guid` = 9997105;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997105, 997005, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1899.25, -690.292, -2.58544, 0, 1200, 0, 0, 0, 0, 0,
    0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26255;

DELETE FROM `creature_addon` WHERE `guid` = 9997105;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997105, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997005;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997005, 0, 0, 'The Mine Breaker signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Venture Co. mine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997005 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997005, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997005, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997006, 0, 0, 0, 0, 0, 'Oreblade Sarn', 'Venture Co. mine', `IconName`, `gossip_menu_id`, 8, 8, `exp`, `faction`,
    0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997006, 0, `skinloot`, 0, 0, 24, 64, 'SmartAI', 0, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2977
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997006;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997006, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2977;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997006;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997006, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2977;

DELETE FROM `creature` WHERE `guid` = 9997106;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997106, 997006, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1946.18, -742.522, -2.19717, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine'
FROM `creature` WHERE `guid` = 26283;

DELETE FROM `creature_addon` WHERE `guid` = 9997106;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997106, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997006;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997006, 0, 0, 'Oreblade Sarn signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Venture Co. mine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997006 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997006, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997006, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993000, `class`, `subclass`, `SoundOverrideSubclass`, 'Miner''s Hide Boots', `displayid`, 2, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 24112
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993001, `class`, `subclass`, `SoundOverrideSubclass`, 'Foreman''s Ledger Robe', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, 12, 7,
    `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, 0, 0, 1,
    `stackable`, `ContainerSlots`, 7, 3, 5, 2, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`,
    `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`,
    `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`,
    `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`,
    `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`,
    `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 9598
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993002, `class`, `subclass`, `SoundOverrideSubclass`, 'Ore Cart War Axe', `displayid`, 3, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    0, 0, 1, `stackable`, `ContainerSlots`, 4, 3, 7, 2, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`,
    `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`,
    `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`,
    `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`,
    `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`,
    `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 3488
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993003, `class`, `subclass`, `SoundOverrideSubclass`, 'Breaker''s Chain Vest', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, 13, 8,
    `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, 0, 0, 1,
    `stackable`, `ContainerSlots`, 4, 3, 7, 2, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`,
    `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, 130, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`,
    `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`,
    `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`,
    `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`,
    `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 3471
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997000;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997000, 2770, 0, 42, 0, 1, 0, 1, 2),
(
    997000, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997001;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997001, 2770, 0, 42, 0, 1, 0, 1, 2),
(
    997001, 1179, 0, 12, 0, 1, 0, 1, 2),
(
    997001, 993000, 0, 5, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997002;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997002, 2770, 0, 42, 0, 1, 0, 1, 2),
(
    997002, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997003;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997003, 2770, 0, 42, 0, 1, 0, 1, 2),
(
    997003, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997004;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997004, 2770, 0, 100, 0, 1, 0, 1, 3),
(
    997004, 1179, 0, 25, 0, 1, 0, 1, 2),
(
    997004, 993001, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997005;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997005, 2770, 0, 100, 0, 1, 0, 1, 3),
(
    997005, 1179, 0, 25, 0, 1, 0, 1, 2),
(
    997005, 993002, 0, 22, 0, 1, 0, 1, 1),
(
    997005, 993003, 0, 22, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997006;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997006, 2770, 0, 100, 0, 1, 0, 1, 3),
(
    997006, 1179, 0, 25, 0, 1, 0, 1, 2),
(
    997006, 993001, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9997400;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997400, 997000, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1946.18, -742.522, -2.19717, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Venture Co. mine rare replacement'
FROM `creature` WHERE `guid` = 26283;

DELETE FROM `creature_addon` WHERE `guid` = 9997400;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997400, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `pool_template` WHERE `entry` = 997000;
INSERT INTO `pool_template` (
    `entry`, `max_limit`, `description`) VALUES
(
    997000, 1, 'Old School Venture Co. mine rare replacement');

DELETE FROM `pool_creature` WHERE `pool_entry` = 997000 AND `guid` IN (9997106, 9997400);
INSERT INTO `pool_creature` (
    `guid`, `pool_entry`, `chance`, `description`) VALUES
(
    9997106, 997000, 30, 'Venture Co. mine rare'),
(
    9997400, 997000, 70, 'Venture Co. mine ordinary');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997010, 0, 0, 0, 0, 0, 'Stronghold Pathfinder', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 22, 22,
    `exp`, `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`,
    1, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`,
    `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, 997010, 0, `skinloot`, 0, 0, 66, 176, 'SmartAI',
    0, `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3456
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997010;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997010, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3456;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997010;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997010, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3456;

DELETE FROM `creature` WHERE `guid` = 9997110;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997110, 997010, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3785.69, -1874.38, 93.7852, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14434;

DELETE FROM `creature_addon` WHERE `guid` = 9997110;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997110, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997010 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997010, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997011, 0, 0, 0, 0, 0, 'Stronghold Stalker', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 22, 22, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997011, 0, `skinloot`, 0, 0, 66, 176, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3457
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997011;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997011, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3457;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997011;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997011, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3457;

DELETE FROM `creature` WHERE `guid` = 9997111;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997111, 997011, `map`, 0, 0, `spawnMask`, 1073741824, 0, -4012.22, -1778.84, 96.5483, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14454;

DELETE FROM `creature_addon` WHERE `guid` = 9997111;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997111, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997011 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997011, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 1758, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997012, 0, 0, 0, 0, 0, 'Stronghold Seer', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 23, 23, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997012, 0, `skinloot`, 0, 0, 69, 184, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3458
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997012;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997012, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3458;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997012;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997012, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3458;

DELETE FROM `creature` WHERE `guid` = 9997112;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997112, 997012, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3816.49, -1523.62, 108.711, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14479;

DELETE FROM `creature_addon` WHERE `guid` = 9997112;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997112, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997012 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997012, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6363, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997013, 0, 0, 0, 0, 0, 'Stronghold Warfrenzy', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 24, 24,
    `exp`, `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`,
    1, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`,
    `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, 997013, 0, `skinloot`, 0, 0, 72, 192, 'SmartAI',
    0, `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3459
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997013;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997013, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3459;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997013;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997013, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3459;

DELETE FROM `creature` WHERE `guid` = 9997113;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997113, 997013, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3901.14, -1659.28, 91.9167, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14907;

DELETE FROM `creature_addon` WHERE `guid` = 9997113;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997113, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997013 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997013, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997014, 0, 0, 0, 0, 0, 'Thornpath Patrol', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 22, 22, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997014, 0, `skinloot`, 0, 0, 66, 176, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3456
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997014;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997014, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3456;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997014;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997014, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3456;

DELETE FROM `creature` WHERE `guid` = 9997114;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997114, 997014, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3995.22, -1752.17, 96.2058, 0, 360, 0, 0, 0, 0, 2, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14441;

DELETE FROM `creature_addon` WHERE `guid` = 9997114;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997114, 99971140, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99971140;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`,
    `move_type`, `action`, `action_chance`, `wpguid`)
SELECT
    99971140, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, `action_chance`, 0
FROM `waypoint_data` WHERE `id` = 144490;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997014 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997014, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997015, 0, 0, 0, 0, 0, 'Thornseer Vakka', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 23, 23, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997015, 0, `skinloot`, 0, 0, 69, 184, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3458
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997015;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997015, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3458;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997015;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997015, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3458;

DELETE FROM `creature` WHERE `guid` = 9997115;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997115, 997015, `map`, 0, 0, `spawnMask`, 1073741824, 0, -4015.68, -1884.3, 92.0455, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14470;

DELETE FROM `creature_addon` WHERE `guid` = 9997115;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997115, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997015;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997015, 0, 0, 'Thornseer Vakka signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Razormane stronghold warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997015 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997015, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6363, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997015, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997016, 0, 0, 0, 0, 0, 'Great-Tusk Rendar', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 23, 23, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997016, 0, `skinloot`, 0, 0, 69, 184, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3459
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997016;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997016, `Idx`, `CreatureDisplayID`, 1.8, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3459;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997016;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997016, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3459;

DELETE FROM `creature` WHERE `guid` = 9997116;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997116, 997016, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3881.93, -1509.84, 138.421, 0, 1200, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14906;

DELETE FROM `creature_addon` WHERE `guid` = 9997116;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997116, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997016;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997016, 0, 0, 'Great-Tusk Rendar signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Razormane stronghold warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997016 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997016, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997016, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997017, 0, 0, 0, 0, 0, 'Thornslink Varr', 'Razormane stronghold', `IconName`, `gossip_menu_id`, 23, 23, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997017, 0, `skinloot`, 0, 0, 69, 184, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3457
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997017;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997017, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3457;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997017;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997017, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3457;

DELETE FROM `creature` WHERE `guid` = 9997117;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997117, 997017, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3910.5, -1849.09, 92.1074, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold'
FROM `creature` WHERE `guid` = 14457;

DELETE FROM `creature_addon` WHERE `guid` = 9997117;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997117, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997017;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997017, 0, 0, 'Thornslink Varr signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Razormane stronghold warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997017 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997017, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 1758, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997017, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993010, `class`, `subclass`, `SoundOverrideSubclass`, 'Thornpath Leather Tunic', `displayid`, 2, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 6197
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993011, `class`, `subclass`, `SoundOverrideSubclass`, 'Thornseer''s Staff', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 1484
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993012, `class`, `subclass`, `SoundOverrideSubclass`, 'Great-Tusk Bark Jacket', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 1486
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993013, `class`, `subclass`, `SoundOverrideSubclass`, 'Rendar''s Cruel Barb', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 5191
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993014, `class`, `subclass`, `SoundOverrideSubclass`, 'Rendar''s Nightthorn', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, 27, 22,
    `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, 0, 0, 1,
    `stackable`, `ContainerSlots`, `stat_type1`, 14, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`,
    `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`,
    `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, 0, 0,
    29.6, 49.3, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`,
    `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`,
    `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`,
    `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`,
    `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`,
    `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 5191
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997010;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997010, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997010, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997011;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997011, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997011, 1205, 0, 12, 0, 1, 0, 1, 2),
(
    997011, 993010, 0, 5, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997012;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997012, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997012, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997013;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997013, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997013, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997014;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997014, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997014, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997015;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997015, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    997015, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997015, 993011, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997016;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997016, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    997016, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997016, 993012, 0, 22, 0, 1, 0, 1, 1),
(
    997016, 993013, 0, 22, 0, 1, 0, 1, 1),
(
    997016, 993014, 0, 2, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997017;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997017, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    997017, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997017, 993011, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9997401;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997401, 997010, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3910.5, -1849.09, 92.1074, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Razormane stronghold rare replacement'
FROM `creature` WHERE `guid` = 14457;

DELETE FROM `creature_addon` WHERE `guid` = 9997401;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997401, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `pool_template` WHERE `entry` = 997001;
INSERT INTO `pool_template` (
    `entry`, `max_limit`, `description`) VALUES
(
    997001, 1, 'Old School Razormane stronghold rare replacement');

DELETE FROM `pool_creature` WHERE `pool_entry` = 997001 AND `guid` IN (9997117, 9997401);
INSERT INTO `pool_creature` (
    `guid`, `pool_entry`, `chance`, `description`) VALUES
(
    9997117, 997001, 30, 'Razormane stronghold rare'),
(
    9997401, 997001, 70, 'Razormane stronghold ordinary');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997020, 0, 0, 0, 0, 0, 'Kolkar Camp Packhound', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 14, 14, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997020, 0, `skinloot`, 0, 0, 42, 112, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 4316
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997020;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997020, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 4316;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997020;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997020, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 4316;

DELETE FROM `creature` WHERE `guid` = 9997120;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997120, 997020, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1279.35, -3153.67, 96.8064, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 20857;

DELETE FROM `creature_addon` WHERE `guid` = 9997120;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997120, 0, 0, 0, 1, 0, 0, '');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997021, 0, 0, 0, 0, 0, 'Kolkar Camp Stormer', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 14, 14, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997021, 0, `skinloot`, 0, 0, 42, 112, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3273
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997021;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997021, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3273;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997021;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997021, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3273;

DELETE FROM `creature` WHERE `guid` = 9997121;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997121, 997021, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1102.19, -2793.72, 91.7917, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 20512;

DELETE FROM `creature_addon` WHERE `guid` = 9997121;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997121, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997021 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997021, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997022, 0, 0, 0, 0, 0, 'Kolkar Camp Runner', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 15, 15, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997022, 0, `skinloot`, 0, 0, 45, 120, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3274
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997022;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997022, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3274;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997022;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997022, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3274;

DELETE FROM `creature` WHERE `guid` = 9997122;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997122, 997022, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1273.0, -2857.46, 93.798, 0, 360, 0, 0, 0, 0, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 20569;

DELETE FROM `creature_addon` WHERE `guid` = 9997122;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997122, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997022 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997022, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997023, 0, 0, 0, 0, 0, 'Kolkar Camp Marauder', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 16, 16, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997023, 0, `skinloot`, 0, 0, 48, 128, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3275
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997023;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997023, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3275;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997023;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997023, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3275;

DELETE FROM `creature` WHERE `guid` = 9997123;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997123, 997023, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1155.23, -2952.66, 93.8838, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 20575;

DELETE FROM `creature_addon` WHERE `guid` = 9997123;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997123, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997023 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997023, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997024, 0, 0, 0, 0, 0, 'Kolkar Blood Patrol', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 15, 15, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997024, 0, `skinloot`, 0, 0, 45, 120, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3397
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997024;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997024, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3397;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997024;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997024, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3397;

DELETE FROM `creature` WHERE `guid` = 9997124;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997124, 997024, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1152.7, -2888.18, 94.2872, 0, 360, 0, 0, 0, 0, 2, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 13994;

DELETE FROM `creature_addon` WHERE `guid` = 9997124;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997124, 99971240, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99971240;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`,
    `move_type`, `action`, `action_chance`, `wpguid`)
SELECT
    99971240, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, `action_chance`, 0
FROM `waypoint_data` WHERE `id` = 140060;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997024 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997024, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997025, 0, 0, 0, 0, 0, 'Stormcaller Ushka', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 15, 15, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997025, 0, `skinloot`, 0, 0, 45, 120, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3273
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997025;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997025, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3273;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997025;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997025, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3273;

DELETE FROM `creature` WHERE `guid` = 9997125;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997125, 997025, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1125.16, -3151.13, 94.1292, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 20524;

DELETE FROM `creature_addon` WHERE `guid` = 9997125;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997125, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997025;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997025, 0, 0, 'Stormcaller Ushka signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Kolkar war camps warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997025 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997025, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997025, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997026, 0, 0, 0, 0, 0, 'Great Kodo Bloodhoof', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 14, 14, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997026, 0, `skinloot`, 0, 0, 42, 112, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3234
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997026;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997026, `Idx`, `CreatureDisplayID`, 1.8, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3234;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997026;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997026, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3234;

DELETE FROM `creature` WHERE `guid` = 9997126;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997126, 997026, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1318.6, -2716.57, 94.0946, 0, 1200, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 15127;

DELETE FROM `creature_addon` WHERE `guid` = 9997126;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997126, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997026;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997026, 0, 0, 'Great Kodo Bloodhoof signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Kolkar war camps warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997026 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997026, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997026, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997027, 0, 0, 0, 0, 0, 'Bloodrunner Sela', 'Kolkar war camps', `IconName`, `gossip_menu_id`, 16, 16, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997027, 0, `skinloot`, 0, 0, 48, 128, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3397
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997027;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997027, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3397;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997027;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997027, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3397;

DELETE FROM `creature` WHERE `guid` = 9997127;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997127, 997027, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1347.32, -2990.78, 92.9249, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps'
FROM `creature` WHERE `guid` = 13998;

DELETE FROM `creature_addon` WHERE `guid` = 9997127;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997127, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997027;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997027, 0, 0, 'Bloodrunner Sela signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Kolkar war camps warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997027 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997027, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon'),
(
    997027, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993020, `class`, `subclass`, `SoundOverrideSubclass`, 'Kolkar Dust Boots', `displayid`, 2, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`,
    `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`,
    `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`,
    `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`,
    `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`,
    `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 14722
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993021, `class`, `subclass`, `SoundOverrideSubclass`, 'Stormcaller Leggings', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 5422
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993022, `class`, `subclass`, `SoundOverrideSubclass`, 'Bloodhoof Shortsword', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 935
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993023, `class`, `subclass`, `SoundOverrideSubclass`, 'Bloodhoof Circle Staff', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 65461
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997020;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997020, 2318, 0, 42, 0, 1, 0, 1, 2),
(
    997020, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997021;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997021, 2318, 0, 42, 0, 1, 0, 1, 2),
(
    997021, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997022;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997022, 2318, 0, 42, 0, 1, 0, 1, 2),
(
    997022, 1205, 0, 12, 0, 1, 0, 1, 2),
(
    997022, 993020, 0, 5, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997023;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997023, 2318, 0, 42, 0, 1, 0, 1, 2),
(
    997023, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997024;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997024, 2318, 0, 42, 0, 1, 0, 1, 2),
(
    997024, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997025;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997025, 2318, 0, 100, 0, 1, 0, 1, 3),
(
    997025, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997025, 993021, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997026;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997026, 2318, 0, 100, 0, 1, 0, 1, 3),
(
    997026, 993022, 0, 22, 0, 1, 0, 1, 1),
(
    997026, 993023, 0, 22, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997027;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997027, 2318, 0, 100, 0, 1, 0, 1, 3),
(
    997027, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997027, 993021, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9997402;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997402, 997020, `map`, 0, 0, `spawnMask`, 1073741824, 0, -1347.32, -2990.78, 92.9249, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Kolkar war camps rare replacement'
FROM `creature` WHERE `guid` = 13998;

DELETE FROM `creature_addon` WHERE `guid` = 9997402;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997402, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `pool_template` WHERE `entry` = 997002;
INSERT INTO `pool_template` (
    `entry`, `max_limit`, `description`) VALUES
(
    997002, 1, 'Old School Kolkar war camps rare replacement');

DELETE FROM `pool_creature` WHERE `pool_entry` = 997002 AND `guid` IN (9997127, 9997402);
INSERT INTO `pool_creature` (
    `guid`, `pool_entry`, `chance`, `description`) VALUES
(
    9997127, 997002, 30, 'Kolkar war camps rare'),
(
    9997402, 997002, 70, 'Kolkar war camps ordinary');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997030, 0, 0, 0, 0, 0, 'Roost Harpy', 'Witchwing roost', `IconName`, `gossip_menu_id`, 15, 15, `exp`, `faction`,
    0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997030, 0, `skinloot`, 0, 0, 45, 120, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3276
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997030;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997030, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3276;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997030;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997030, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3276;

DELETE FROM `creature` WHERE `guid` = 9997130;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997130, 997030, `map`, 0, 0, `spawnMask`, 1073741824, 0, 650.825, -1547.5, 99.3995, 0, 360, 0, 0, 0, 0, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20592;

DELETE FROM `creature_addon` WHERE `guid` = 9997130;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997130, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997030 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997030, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 7098, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997031, 0, 0, 0, 0, 0, 'Roost Roguefeather', 'Witchwing roost', `IconName`, `gossip_menu_id`, 16, 16, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997031, 0, `skinloot`, 0, 0, 48, 128, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3277
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997031;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997031, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3277;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997031;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997031, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3277;

DELETE FROM `creature` WHERE `guid` = 9997131;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997131, 997031, `map`, 0, 0, `spawnMask`, 1073741824, 0, 408.839, -1469.78, 91.7917, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20615;

DELETE FROM `creature_addon` WHERE `guid` = 9997131;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997131, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997031 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997031, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 7992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997032, 0, 0, 0, 0, 0, 'Roost Slayer', 'Witchwing roost', `IconName`, `gossip_menu_id`, 17, 17, `exp`, `faction`,
    0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997032, 0, `skinloot`, 0, 0, 51, 136, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3278
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997032;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997032, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3278;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997032;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997032, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3278;

DELETE FROM `creature` WHERE `guid` = 9997132;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997132, 997032, `map`, 0, 0, `spawnMask`, 1073741824, 0, 723.913, -1272.05, 92.4167, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20671;

DELETE FROM `creature_addon` WHERE `guid` = 9997132;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997132, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997032 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997032, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997033, 0, 0, 0, 0, 0, 'Roost Windcaller', 'Witchwing roost', `IconName`, `gossip_menu_id`, 18, 18, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997033, 0, `skinloot`, 0, 0, 54, 144, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3280
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997033;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997033, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3280;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997033;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997033, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3280;

DELETE FROM `creature` WHERE `guid` = 9997133;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997133, 997033, `map`, 0, 0, `spawnMask`, 1073741824, 0, 459.715, -1272.37, 92.0417, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20689;

DELETE FROM `creature_addon` WHERE `guid` = 9997133;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997133, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997033 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997033, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997034, 0, 0, 0, 0, 0, 'Roost Ambush Patrol', 'Witchwing roost', `IconName`, `gossip_menu_id`, 17, 17, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997034, 0, `skinloot`, 0, 0, 51, 136, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3279
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997034;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997034, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3279;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997034;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997034, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3279;

DELETE FROM `creature` WHERE `guid` = 9997134;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997134, 997034, `map`, 0, 0, `spawnMask`, 1073741824, 0, 512.223, -1384.84, 91.6667, 0, 360, 0, 0, 0, 0, 2, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20687;

DELETE FROM `creature_addon` WHERE `guid` = 9997134;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997134, 99971340, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99971340;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`,
    `move_type`, `action`, `action_chance`, `wpguid`)
SELECT
    99971340, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, `action_chance`, 0
FROM `waypoint_data` WHERE `id` = 206620;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997034 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997034, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 7992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997035, 0, 0, 0, 0, 0, 'Windcaller Shree', 'Witchwing roost', `IconName`, `gossip_menu_id`, 17, 17, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997035, 0, `skinloot`, 0, 0, 51, 136, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3280
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997035;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997035, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3280;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997035;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997035, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3280;

DELETE FROM `creature` WHERE `guid` = 9997135;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997135, 997035, `map`, 0, 0, `spawnMask`, 1073741824, 0, 546.728, -1511.84, 93.5783, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20711;

DELETE FROM `creature_addon` WHERE `guid` = 9997135;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997135, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997035;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997035, 0, 0, 'Windcaller Shree signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Witchwing roost warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997035 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997035, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 6728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997035, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997036, 0, 0, 0, 0, 0, 'The Great Shriek', 'Witchwing roost', `IconName`, `gossip_menu_id`, 16, 16, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997036, 0, `skinloot`, 0, 0, 48, 128, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3278
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997036;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997036, `Idx`, `CreatureDisplayID`, 1.8, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3278;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997036;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997036, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3278;

DELETE FROM `creature` WHERE `guid` = 9997136;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997136, 997036, `map`, 0, 0, `spawnMask`, 1073741824, 0, 553.345, -1257.24, 92.0416, 0, 1200, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20650;

DELETE FROM `creature_addon` WHERE `guid` = 9997136;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997136, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997036;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997036, 0, 0, 'The Great Shriek signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Witchwing roost warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997036 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997036, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997036, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997037, 0, 0, 0, 0, 0, 'Talonshade Veka', 'Witchwing roost', `IconName`, `gossip_menu_id`, 17, 17, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997037, 0, `skinloot`, 0, 0, 51, 136, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3277
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997037;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    997037, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3277;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997037;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    997037, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3277;

DELETE FROM `creature` WHERE `guid` = 9997137;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997137, 997037, `map`, 0, 0, `spawnMask`, 1073741824, 0, 567.049, -1446.2, 92.7917, 0, 900, 0, 0, 0, 0, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost'
FROM `creature` WHERE `guid` = 20622;

DELETE FROM `creature_addon` WHERE `guid` = 9997137;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997137, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 997037;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    997037, 0, 0, 'Talonshade Veka signals a dangerous final stand!', 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School Witchwing roost warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997037 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997037, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 14000, 0, 0, 11, 7992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
    0, 'Old School public dungeon'),
(
    997037, 0, 1, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993050, `class`, `subclass`, `SoundOverrideSubclass`, 'Witchwing Cloth Robe', `displayid`, 2, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 6528
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993051, `class`, `subclass`, `SoundOverrideSubclass`, 'Shree''s Witching Staff', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 1484
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993052, `class`, `subclass`, `SoundOverrideSubclass`, 'Great Shriek Bark Jacket', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 1486
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993053, `class`, `subclass`, `SoundOverrideSubclass`, 'Shriek Assassin Blade', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 1935
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997030;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997030, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997030, 1205, 0, 12, 0, 1, 0, 1, 2),
(
    997030, 993050, 0, 5, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997031;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997031, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997031, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997032;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997032, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997032, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997033;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997033, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997033, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997034;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997034, 2589, 0, 42, 0, 1, 0, 1, 2),
(
    997034, 1205, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997035;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997035, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    997035, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997035, 993051, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997036;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997036, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    997036, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997036, 993052, 0, 22, 0, 1, 0, 1, 1),
(
    997036, 993053, 0, 22, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997037;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997037, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    997037, 1205, 0, 25, 0, 1, 0, 1, 2),
(
    997037, 993051, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9997403;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997403, 997030, `map`, 0, 0, `spawnMask`, 1073741824, 0, 567.049, -1446.2, 92.7917, 0, 360, 0, 0, 0, 0, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`, 'Old School Witchwing roost rare replacement'
FROM `creature` WHERE `guid` = 20622;

DELETE FROM `creature_addon` WHERE `guid` = 9997403;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997403, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `pool_template` WHERE `entry` = 997003;
INSERT INTO `pool_template` (
    `entry`, `max_limit`, `description`) VALUES
(
    997003, 1, 'Old School Witchwing roost rare replacement');

DELETE FROM `pool_creature` WHERE `pool_entry` = 997003 AND `guid` IN (9997137, 9997403);
INSERT INTO `pool_creature` (
    `guid`, `pool_entry`, `chance`, `description`) VALUES
(
    9997137, 997003, 30, 'Witchwing roost rare'),
(
    9997403, 997003, 70, 'Witchwing roost ordinary');

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993040, `class`, `subclass`, `SoundOverrideSubclass`, 'Sharptusk Thorncleaver', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 3488
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

UPDATE `creature_template` SET `minlevel` = 5, `maxlevel` = 5 WHERE `entry` = 996935;
UPDATE `creature_template` SET `minlevel` = 5, `maxlevel` = 5 WHERE `entry` = 996936;
UPDATE `creature_template` SET `minlevel` = 6, `maxlevel` = 6 WHERE `entry` = 996937;
UPDATE `creature_template` SET `minlevel` = 6, `maxlevel` = 6 WHERE `entry` = 996938;
UPDATE `creature_template` SET `minlevel` = 5, `maxlevel` = 5 WHERE `entry` = 996940;
UPDATE `creature_template` SET `minlevel` = 6, `maxlevel` = 6 WHERE `entry` = 996941;
UPDATE `creature_template_model` SET `DisplayScale` = 1.8 WHERE `CreatureID` = 996936;
INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993041, `class`, `subclass`, `SoundOverrideSubclass`, 'Ravine Forager Trousers', `displayid`, 2, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 2958
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993042, `class`, `subclass`, `SoundOverrideSubclass`, 'Ravine Ritual Robe', `displayid`, 2, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 6238
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993043, `class`, `subclass`, `SoundOverrideSubclass`, 'Ravine Warleader Axe', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
    `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`,
    `stat_value9`, `stat_type10`, `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`,
    `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
    `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`,
    `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`,
    `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`,
    `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`,
    `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`,
    `spellcategory_5`, `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`,
    `startquest`, `lockid`, `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`,
    `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 3488
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996930 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996930, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996931 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996931, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996933 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996933, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996934 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996934, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996935 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996935, 1179, 0, 25, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996937 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996937, 1179, 0, 25, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996938 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996938, 1179, 0, 25, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996940 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996940, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996941 AND `Item` = 1179;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996941, 1179, 0, 12, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996930 AND `Item` = 993041;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996930, 993041, 0, 5, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996933 AND `Item` = 993042;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996933, 993042, 0, 5, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996938 AND `Item` = 993043;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996938, 993043, 0, 18, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9997200;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997200, 996930, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3146.75, -1056.96, 56.4398, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132314;

DELETE FROM `creature_addon` WHERE `guid` = 9997200;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997200, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997201;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997201, 996931, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3081.21, -1055.09, 52.6625, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132316;

DELETE FROM `creature_addon` WHERE `guid` = 9997201;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997201, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997202;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997202, 996932, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3044.84, -1054.97, 52.5994, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132318;

DELETE FROM `creature_addon` WHERE `guid` = 9997202;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997202, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997203;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997203, 996933, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3048.05, -1120.15, 62.4051, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132320;

DELETE FROM `creature_addon` WHERE `guid` = 9997203;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997203, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997204;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997204, 996934, `map`, 0, 0, `spawnMask`, 1073741824, 0, -2978.22, -1021.43, 55.2015, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132325;

DELETE FROM `creature_addon` WHERE `guid` = 9997204;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997204, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997205;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997205, 996930, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3089.48, -1092.48, 71.4338, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132330;

DELETE FROM `creature_addon` WHERE `guid` = 9997205;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997205, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997206;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997206, 996933, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3082.02, -1153.57, 69.2993, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132331;

DELETE FROM `creature_addon` WHERE `guid` = 9997206;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997206, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997207;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997207, 996934, `map`, 0, 0, `spawnMask`, 1073741824, 0, -3062.19, -1157.89, 66.4109, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School central Bristleback Ravine'
FROM `creature` WHERE `guid` = 132332;

DELETE FROM `creature_addon` WHERE `guid` = 9997207;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997207, 0, 0, 0, 1, 0, 0, '');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`,
    `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`, `VerifiedBuild`)
SELECT
    997041, 0, 0, 0, 0, 0, 'Gravehide Tusker', 'Bristleback Ravine', `IconName`, `gossip_menu_id`, 6, 6, `exp`,
    `faction`, 0, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 997041, 0, `skinloot`, 0, 0, `mingold`, `maxgold`, 'SmartAI', 0,
    `HoverHeight`, 1, `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2954
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`), `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`), `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`), `name` = VALUES(`name`), `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`), `gossip_menu_id` = VALUES(`gossip_menu_id`), `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`), `exp` = VALUES(`exp`), `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`), `speed_walk` = VALUES(`speed_walk`), `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`), `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`), `rank` = VALUES(`rank`), `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`), `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`), `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`), `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`), `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`), `family` = VALUES(`family`), `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`), `lootid` = VALUES(`lootid`), `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`), `PetSpellDataId` = VALUES(`PetSpellDataId`), `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`), `maxgold` = VALUES(`maxgold`), `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`), `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`), `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`), `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`), `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`), `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`), `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997041;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) SELECT 997041, `Idx`, `CreatureDisplayID`, 1.25, `Probability`, `VerifiedBuild` FROM `creature_template_model` WHERE `CreatureID` = 2954;
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997041;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) SELECT 997041, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild` FROM `creature_equip_template` WHERE `CreatureID` = 2954;
INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`,
    `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`,
    `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`,
    `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`,
    `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`,
    `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`,
    `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`,
    `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`,
    `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)
SELECT
    993044, `class`, `subclass`, `SoundOverrideSubclass`, 'Gravehide Tusker Boots', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
    `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,
    `RequiredCityRank`, 0, 0, 1, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, 3, 1, `stat_type3`,
    `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`,
    `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`,
    `stat_value10`, 0, 0, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`,
    `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`,
    `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`,
    `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`,
    `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`,
    `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`,
    `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`,
    `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,
    `spellcategorycooldown_5`, 2, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`,
    `Material`, `sheath`, 0, 0, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`,
    `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`,
    `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`,
    `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`,
    `flagsCustom`, `VerifiedBuild`
FROM `item_template` WHERE `entry` = 24112
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`), `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`), `Quality` = VALUES(`Quality`), `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`), `BuyCount` = VALUES(`BuyCount`), `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`), `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`), `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`), `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`), `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`), `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`), `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`), `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`), `stat_value1` = VALUES(`stat_value1`), `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`), `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`), `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`), `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`), `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`), `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`), `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`), `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`), `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`), `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`), `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`), `dmg_type1` = VALUES(`dmg_type1`), `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`), `dmg_type2` = VALUES(`dmg_type2`), `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`), `fire_res` = VALUES(`fire_res`), `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`), `shadow_res` = VALUES(`shadow_res`), `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`), `ammo_type` = VALUES(`ammo_type`), `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`), `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`), `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`), `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`), `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`), `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`), `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`), `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`), `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`), `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`), `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`), `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`), `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`), `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`), `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`), `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`), `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`), `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`), `PageText` = VALUES(`PageText`), `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`), `startquest` = VALUES(`startquest`), `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`), `sheath` = VALUES(`sheath`), `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`), `block` = VALUES(`block`), `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`), `area` = VALUES(`area`), `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`), `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`), `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`), `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`), `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`), `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`), `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`), `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`), `DisenchantID` = VALUES(`DisenchantID`), `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`), `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997041;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    997041, 2318, 0, 100, 0, 1, 0, 1, 3),
(
    997041, 993044, 0, 20, 0, 1, 0, 1, 1);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997041 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    997041, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 3385, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School public dungeon');

DELETE FROM `creature` WHERE `guid` = 9997410;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997410, 996932, `map`, 0, 0, `spawnMask`, 1073741824, 0, -2992.75, -1004.04, 58.735, 0, 360, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback rare replacement'
FROM `creature` WHERE `guid` = 132326;

DELETE FROM `creature_addon` WHERE `guid` = 9997410;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997410, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997411;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997411, 997041, `map`, 0, 0, `spawnMask`, 1073741824, 0, -2992.75, -1004.04, 58.735, 0, 900, 0, 0, 0, 0, 0, 0,
    0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback rare replacement'
FROM `creature` WHERE `guid` = 132326;

DELETE FROM `creature_addon` WHERE `guid` = 9997411;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997411, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `pool_template` WHERE `entry` = 997004;
INSERT INTO `pool_template` (
    `entry`, `max_limit`, `description`) VALUES
(
    997004, 1, 'Old School Bristleback rare replacement');

DELETE FROM `pool_creature` WHERE `pool_entry` = 997004 AND `guid` IN (9997410, 9997411);
INSERT INTO `pool_creature` (
    `guid`, `pool_entry`, `chance`, `description`) VALUES
(
    9997410, 997004, 70, 'Ravine battleboar'),
(
    9997411, 997004, 30, 'Gravehide Tusker');
