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
    996930, 0, 0, 0, 0, 0, 'Ravine Supply Forager', 'Bristleback Ravine', `IconName`, 0, 4, 4, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996930, 0, `skinloot`, 0, 0, 12, 32, '', 0, `HoverHeight`, 1, `ManaModifier`,
    `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, '',
    `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2952
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996930;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996930, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2952;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996930;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996930, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2952;

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
    996931, 0, 0, 0, 0, 0, 'Ravine Pen Keeper', 'Bristleback Ravine', `IconName`, 0, 6, 6, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996931, 0, `skinloot`, 0, 0, 18, 48, '', 0, `HoverHeight`, 1, `ManaModifier`,
    `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, '',
    `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2952
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996931;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996931, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2952;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996931;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996931, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2952;

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
    996932, 0, 0, 0, 0, 0, 'Ravine Battleboar', 'Bristleback Ravine', `IconName`, 0, 6, 6, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996932, 0, `skinloot`, 0, 0, 18, 48, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996932;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996932, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2954;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996932;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996932, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2954;

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
    996933, 0, 0, 0, 0, 0, 'Ravine Thornspeaker', 'Bristleback Ravine', `IconName`, 0, 7, 7, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996933, 0, `skinloot`, 0, 0, 21, 56, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2953
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996933;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996933, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2953;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996933;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996933, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2953;

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
    996934, 0, 0, 0, 0, 0, 'Ravine Banner Guard', 'Bristleback Ravine', `IconName`, 0, 8, 8, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996934, 0, `skinloot`, 0, 0, 24, 64, '', 0, `HoverHeight`, 1, `ManaModifier`,
    `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, '',
    `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2952
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996934;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996934, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2952;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996934;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996934, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2952;

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
    996935, 0, 0, 0, 0, 0, 'Quartermaster Ruk', 'Bristleback Ravine', `IconName`, 0, 5, 5, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996935, 0, `skinloot`, 0, 0, 15, 40, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2952
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996935;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996935, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2952;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996935;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996935, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2952;

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
    996936, 0, 0, 0, 0, 0, 'Goretusk Penbreaker', 'Bristleback Ravine', `IconName`, 0, 7, 7, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996936, 0, `skinloot`, 0, 0, 21, 56, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996936;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996936, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2954;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996936;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996936, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2954;

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
    996937, 0, 0, 0, 0, 0, 'Ashcaller Vesh', 'Bristleback Ravine', `IconName`, 0, 8, 8, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996937, 0, `skinloot`, 0, 0, 24, 64, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2953
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996937;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996937, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2953;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996937;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996937, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2953;

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
    996938, 0, 0, 0, 0, 0, 'Warbanner Kraz', 'Bristleback Ravine', `IconName`, 0, 10, 10, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996938, 0, `skinloot`, 0, 0, 30, 80, 'SmartAI', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 3229
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996938;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996938, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 3229;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996938;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996938, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 3229;

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
    996939, 0, 0, 0, 0, 0, 'Ravine Scout Tahu', 'Old School expedition guide', `IconName`, 996939, 6, 6, `exp`,
    `faction`, 1, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, 0, 0, `skinloot`, 0, 0, 0, 0, '', 0, `HoverHeight`, 1,
    `ManaModifier`, `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2980
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996939;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996939, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2980;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996939;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996939, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2980;

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
    996940, 0, 0, 0, 0, 0, 'Ravine Supply Runner', 'Bristleback Ravine', `IconName`, 0, 6, 6, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996940, 0, `skinloot`, 0, 0, 18, 48, '', 0, `HoverHeight`, 1, `ManaModifier`,
    `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, '',
    `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2952
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996940;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996940, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2952;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996940;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996940, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2952;

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
    996941, 0, 0, 0, 0, 0, 'Ravine Warbanner Patrol', 'Bristleback Ravine', `IconName`, 0, 9, 9, `exp`, `faction`, 0,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, 0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
    `family`, `type`, `type_flags`, 996941, 0, `skinloot`, 0, 0, 27, 72, '', 0, `HoverHeight`, 1, `ManaModifier`,
    `ArmorModifier`, 1, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, '',
    `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 2952
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

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996941;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT
    996941, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 2952;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996941;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT
    996941, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 2952;

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
    996935, `class`, `subclass`, `SoundOverrideSubclass`, 'Supplykeeper''s Linen Trousers', `displayid`, `Quality`,
    `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`,
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
    996936, `class`, `subclass`, `SoundOverrideSubclass`, 'Penbreaker Hide Boots', `displayid`, `Quality`, `Flags`,
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
FROM `item_template` WHERE `entry` = 2309
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
    996937, `class`, `subclass`, `SoundOverrideSubclass`, 'Ashcaller''s Linen Robe', `displayid`, `Quality`, `Flags`,
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
    996938, `class`, `subclass`, `SoundOverrideSubclass`, 'Ravine War Axe', `displayid`, `Quality`, `Flags`,
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
    996942, `class`, `subclass`, `SoundOverrideSubclass`, 'Warbanner Chain Vest', `displayid`, `Quality`, `Flags`,
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

DELETE FROM `creature_loot_template` WHERE `Entry` = 996930;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996930, 2589, 0, 40, 0, 1, 0, 1, 2),
(
    996930, 2835, 0, 20, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996931;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996931, 2770, 0, 35, 0, 1, 0, 1, 2),
(
    996931, 2835, 0, 20, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996932;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996932, 2318, 0, 40, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996933;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996933, 2589, 0, 40, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996934;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996934, 2770, 0, 40, 0, 1, 0, 1, 2),
(
    996934, 2835, 0, 20, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996935;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996935, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    996935, 996935, 0, 25, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996936;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996936, 2318, 0, 100, 0, 1, 0, 1, 3),
(
    996936, 996936, 0, 25, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996937;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996937, 2589, 0, 100, 0, 1, 0, 1, 3),
(
    996937, 996937, 0, 25, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996938;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996938, 2770, 0, 100, 0, 1, 0, 1, 3),
(
    996938, 996938, 0, 15, 0, 1, 0, 1, 1),
(
    996938, 996942, 0, 15, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996940;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996940, 2589, 0, 40, 0, 1, 0, 1, 2),
(
    996940, 2835, 0, 20, 0, 1, 0, 1, 2);

DELETE FROM `creature_loot_template` WHERE `Entry` = 996941;
INSERT INTO `creature_loot_template` (
    `Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(
    996941, 2770, 0, 40, 0, 1, 0, 1, 2),
(
    996941, 2835, 0, 20, 0, 1, 0, 1, 2);

DELETE FROM `creature` WHERE `guid` = 9997000;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997000, 996935, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3162.74, -965.176, 51.1485, 0, 900, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997000;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997000, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997001;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997001, 996930, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3149.19, -999.854, 50.9788, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997001;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997001, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997002;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997002, 996930, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3184.69, -940.814, 51.6136, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997002;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997002, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997003;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997003, 996930, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3135.29, -1009.49, 50.9302, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997003;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997003, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997004;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997004, 996936, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3038.55, -1169.96, 62.8823, 0, 900, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997004;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997004, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997005;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997005, 996931, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3090.17, -1118.49, 77.0913, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997005;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997005, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997006;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997006, 996932, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3063.09, -1039.93, 49.152, 0, 360, 0, 0,
    0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997006;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997006, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997007;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997007, 996932, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3020.82, -1170.21, 61.3235, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997007;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997007, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997008;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997008, 996937, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2839.36, -1053.08, 66.2612, 0, 900, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997008;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997008, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997009;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997009, 996933, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2836.17, -1068.33, 72.7313, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997009;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997009, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997010;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997010, 996933, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2863.0, -1041.67, 54.6391, 0, 360, 0, 0,
    0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997010;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997010, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997011;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997011, 996933, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2847.57, -1084.51, 78.3085, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997011;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997011, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997012;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997012, 996938, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3078.32, -1212.44, 86.5053, 0, 900, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997012;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997012, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997013;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997013, 996934, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2990.21, -1234.63, 64.4468, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997013;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997013, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997014;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997014, 996934, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -3034.99, -1226.62, 74.357, 0, 360, 0, 0,
    0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997014;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997014, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997015;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997015, 996934, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2970.36, -1236.79, 64.6368, 0, 360, 0,
    0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997015;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997015, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9997016;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997016, 996940, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2966.63, -1166.78, 59.7903, 0, 360, 0,
    0, 0, 0, 2, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997016;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997016, 99970160, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99970160;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`,
    `move_type`, `action`, `action_chance`, `wpguid`)
SELECT
    99970160, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, `action_chance`, 0
FROM `waypoint_data` WHERE `id` = 1323560;

DELETE FROM `creature` WHERE `guid` = 9997017;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997017, 996941, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2946.33, -1252.16, 71.8886, 0, 360, 0,
    0, 0, 0, 2, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine'
FROM `creature` WHERE `guid` = 132315;

DELETE FROM `creature_addon` WHERE `guid` = 9997017;
INSERT INTO `creature_addon` (
    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(
    9997017, 99970170, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99970170;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`,
    `move_type`, `action`, `action_chance`, `wpguid`)
SELECT
    99970170, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, `action_chance`, 0
FROM `waypoint_data` WHERE `id` = 1323540;

DELETE FROM `creature` WHERE `guid` = 9997018;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
    9997018, 996939, `map`, `zoneId`, `areaId`, `spawnMask`, 1073741824, 0, -2916.7, `position_y`, `position_z`, 1.6,
    120, 0, 0, 0, 0, 0, 0, 0, 0, '', `VerifiedBuild`, `CreateObject`, 'Old School Bristleback Ravine guide'
FROM `creature` WHERE `guid` = 26558;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996932 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    996932, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 3385, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 996933 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    996933, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 10000, 0, 0, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99693501 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    99693501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693501, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693501, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `creature_text` WHERE `CreatureID` = 996935;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    996935, 0, 0, 'Quartermaster Ruk stamps furiously! A short frenzy is coming.', 16, 0, 100, 0, 0, 0, 0, 0,
    'Bristleback Ravine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9997000 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    -9997000, 0, 10, 0, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 80, 99693501, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    -9997000, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99693601 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    99693601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693601, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693601, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `creature_text` WHERE `CreatureID` = 996936;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    996936, 0, 0, 'Goretusk Penbreaker stamps furiously! A short frenzy is coming.', 16, 0, 100, 0, 0, 0, 0, 0,
    'Bristleback Ravine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9997004 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    -9997004, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 3385, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    -9997004, 0, 10, 0, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 80, 99693601, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    -9997004, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99693701 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    99693701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693701, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `creature_text` WHERE `CreatureID` = 996937;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    996937, 0, 0, 'Ashcaller Vesh gathers lightning! Break the coming cast.', 16, 0, 100, 0, 0, 0, 0, 0,
    'Bristleback Ravine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9997008 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    -9997008, 0, 10, 0, 0, 0, 100, 0, 8000, 10000, 18000, 22000, 0, 0, 80, 99693701, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 'Old School Bristleback Ravine'),
(
    -9997008, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99693801 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    99693801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693801, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    99693801, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `creature_text` WHERE `CreatureID` = 996938;
INSERT INTO `creature_text` (
    `CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `BroadcastTextId`, `TextRange`, `comment`) VALUES
(
    996938, 0, 0, 'Warbanner Kraz stamps furiously! A short frenzy is coming.', 16, 0, 100, 0, 0, 0, 0, 0,
    'Bristleback Ravine warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9997012 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(
    -9997012, 0, 10, 0, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 80, 99693801, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine'),
(
    -9997012, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School Bristleback Ravine');

DELETE FROM `npc_text` WHERE `ID` = 996939;
INSERT INTO `npc_text` (
    `ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(
    996939,
    'The Bristleback ravine east of Red Cloud Mesa is growing restless. Scouts can hunt the '
    'supply hollow, but the pens, ritual rise and warbanner hold stronger foes. Two sentry '
    'routes cross these camps. Consider before pulling, watch the patrols, and bring companions '
    'for named leaders. These woods and ledges belong to everyone in Old School; there is no '
    'instance portal.',
    'The Bristleback ravine east of Red Cloud Mesa is growing restless. Scouts can hunt the '
    'supply hollow, but the pens, ritual rise and warbanner hold stronger foes. Two sentry '
    'routes cross these camps. Consider before pulling, watch the patrols, and bring companions '
    'for named leaders. These woods and ledges belong to everyone in Old School; there is no '
    'instance portal.',
    1);

DELETE FROM `gossip_menu` WHERE `MenuID` = 996939;
INSERT INTO `gossip_menu` (
    `MenuID`, `TextID`) VALUES
(
    996939, 996939);

DELETE FROM `npc_text` WHERE `ID` = 996940;
INSERT INTO `npc_text` (
    `ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(
    996940,
    'Follow the low entrance toward the supply hollow. The boar pens lie farther along the '
    'central trail. The eastern climb leads to the ritual rise; the southern ledge leads toward '
    'the warbanner. You can choose either deeper approach and return to the hollow between '
    'hunts. Make your own camp with harvested wood outside patrol routes. Camp Rested and '
    'seated recovery work as elsewhere in Old School; this expedition gives no free camp or '
    'automatic safe area.',
    'Follow the low entrance toward the supply hollow. The boar pens lie farther along the '
    'central trail. The eastern climb leads to the ritual rise; the southern ledge leads toward '
    'the warbanner. You can choose either deeper approach and return to the hollow between '
    'hunts. Make your own camp with harvested wood outside patrol routes. Camp Rested and '
    'seated recovery work as elsewhere in Old School; this expedition gives no free camp or '
    'automatic safe area.',
    1);

DELETE FROM `gossip_menu` WHERE `MenuID` = 996940;
INSERT INTO `gossip_menu` (
    `MenuID`, `TextID`) VALUES
(
    996940, 996940);

DELETE FROM `npc_text` WHERE `ID` = 996941;
INSERT INTO `npc_text` (
    `ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(
    996941,
    'Quartermaster Ruk may carry linen trousers. Goretusk Penbreaker may yield hide boots. '
    'Ashcaller Vesh may carry a linen robe. Warbanner Kraz may carry a war axe or chain vest. '
    'These are fixed, tradeable upgrades with normal level requirements. Named leaders return '
    'roughly every fifteen minutes; guards return every six. Ordinary foes carry linen, light '
    'leather, copper ore or rough stone for existing tailoring, leatherworking and smithing '
    'recipes. Drops are chances, not guaranteed equipment.',
    'Quartermaster Ruk may carry linen trousers. Goretusk Penbreaker may yield hide boots. '
    'Ashcaller Vesh may carry a linen robe. Warbanner Kraz may carry a war axe or chain vest. '
    'These are fixed, tradeable upgrades with normal level requirements. Named leaders return '
    'roughly every fifteen minutes; guards return every six. Ordinary foes carry linen, light '
    'leather, copper ore or rough stone for existing tailoring, leatherworking and smithing '
    'recipes. Drops are chances, not guaranteed equipment.',
    1);

DELETE FROM `gossip_menu` WHERE `MenuID` = 996941;
INSERT INTO `gossip_menu` (
    `MenuID`, `TextID`) VALUES
(
    996941, 996941);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (996939, 996940, 996941);
INSERT INTO `gossip_menu_option` (
    `MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`) VALUES
(
    996939, 0, 0, 'Tell me about the routes and camps.', 1, 1, 996940),
(
    996939, 1, 0, 'What can we recover or craft?', 1, 1, 996941),
(
    996940, 0, 0, 'What can we recover or craft?', 1, 1, 996941),
(
    996941, 0, 0, 'Tell me about the routes and camps.', 1, 1, 996940);
