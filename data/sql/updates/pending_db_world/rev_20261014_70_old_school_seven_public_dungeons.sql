-- Tiragarde Keep: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997100, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Keep Deckhand', 'Tiragarde Keep',
    `IconName`, 0, 7, 7,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997100, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3128
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997100;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997100, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3128;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997100;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997100, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3128;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997100 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997100, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3128 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997101, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Keep Shieldbearer', 'Tiragarde Keep',
    `IconName`, 0, 7, 7,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997101, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3129
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997101;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997101, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3129;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997101;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997101, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3129;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997101 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997101, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3129 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997102, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Tiragarde Shore Patrol', 'Tiragarde Keep',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997102, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3129
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997102;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997102, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3129;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997102;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997102, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3129;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997102 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997102, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3129 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997103, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Lieutenant''s Quartermaster', 'Tiragarde Keep',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997103, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3192
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997103;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997103, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3192;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997103;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997103, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3192;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997103 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997103, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3192 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997104, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Tiragarde Tidebreaker', 'Tiragarde Keep',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997104, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3192
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997104;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997104, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3192;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997104;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997104, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3192;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997104 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997104, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3192 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997105, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Keep Bulwark', 'Tiragarde Keep',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997105, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3192
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997105;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997105, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3192;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997105;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997105, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3192;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997105 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997105, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3192 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

DELETE FROM `creature_text` WHERE `CreatureID` = 997105;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997105, 0, 0, 'Giant Keep Bulwark roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997105 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997105, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997105, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998010 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998010, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997105, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998010, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997106, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Keep Approach Scout', 'Old School public expedition',
    `IconName`, 997106, 7, 7,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 5809
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997106;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997106, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 5809;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997106;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997106, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 5809;

DELETE FROM `npc_text` WHERE `ID` = 997106;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997106, 'Tiragarde Keep is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Tiragarde Keep is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997106;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997106, 997106);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994000, `class`, `subclass`, `SoundOverrideSubclass`,
    'Keep Supply Gloves', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 6), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2403
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994001, `class`, `subclass`, `SoundOverrideSubclass`,
    'Lieutenant''s Vest', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 6), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1155904
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994002, `class`, `subclass`, `SoundOverrideSubclass`,
    'Tidebreaker''s Hammer', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 6), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 450682
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994003, `class`, `subclass`, `SoundOverrideSubclass`,
    'Bulwark Leather Mask', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 6), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 500662
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994004, `class`, `subclass`, `SoundOverrideSubclass`,
    'Giant Bulwark Chestguard', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 6), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2063970
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994005, `class`, `subclass`, `SoundOverrideSubclass`,
    'Bulwark Oath Gauntlets', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 6), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1152626
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997100;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997100, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997100, 2770, 0, 35, 0, 1, 0, 1, 2),
    (997100, 159, 0, 25, 0, 1, 0, 1, 2),
    (997100, 994000, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997101;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997101, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997101, 2770, 0, 35, 0, 1, 0, 1, 2),
    (997101, 159, 0, 25, 0, 1, 0, 1, 2),
    (997101, 994000, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997102;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997102, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997102, 2770, 0, 35, 0, 1, 0, 1, 2),
    (997102, 159, 0, 25, 0, 1, 0, 1, 2),
    (997102, 994000, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997103;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997103, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997103, 2770, 0, 35, 0, 1, 0, 1, 2),
    (997103, 159, 0, 25, 0, 1, 0, 1, 2),
    (997103, 994001, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997104;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997104, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997104, 2770, 0, 35, 0, 1, 0, 1, 2),
    (997104, 159, 0, 25, 0, 1, 0, 1, 2),
    (997104, 994002, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997105;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997105, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997105, 2770, 0, 35, 0, 1, 0, 1, 2),
    (997105, 159, 0, 25, 0, 1, 0, 1, 2),
    (997105, 994003, 0, 30, 0, 1, 0, 1, 1),
    (997105, 994004, 0, 30, 0, 1, 0, 1, 1),
    (997105, 994005, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998000;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998000, 997100, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep ordinary'
FROM `creature`
WHERE `guid` = 12349;

DELETE FROM `creature_addon` WHERE `guid` = 9998000;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998000, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998001;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998001, 997101, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep ordinary'
FROM `creature`
WHERE `guid` = 4772;

DELETE FROM `creature_addon` WHERE `guid` = 9998001;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998001, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998002;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998002, 997100, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep ordinary'
FROM `creature`
WHERE `guid` = 7262;

DELETE FROM `creature_addon` WHERE `guid` = 9998002;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998002, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998003;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998003, 997101, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep ordinary'
FROM `creature`
WHERE `guid` = 4773;

DELETE FROM `creature_addon` WHERE `guid` = 9998003;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998003, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998004;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998004, 997100, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep ordinary'
FROM `creature`
WHERE `guid` = 12267;

DELETE FROM `creature_addon` WHERE `guid` = 9998004;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998004, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998005;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998005, 997101, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep ordinary'
FROM `creature`
WHERE `guid` = 8409;

DELETE FROM `creature_addon` WHERE `guid` = 9998005;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998005, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998006;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998006, 997102, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 0.0, `position_y` + 0.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep patrol'
FROM `creature`
WHERE `guid` = 12998;

DELETE FROM `creature_addon` WHERE `guid` = 9998006;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998006, 99980060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998007;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998007, 997103, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep leader'
FROM `creature`
WHERE `guid` = 12366;

DELETE FROM `creature_addon` WHERE `guid` = 9998007;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998007, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998008;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998008, 997100, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep rare pool ordinary'
FROM `creature`
WHERE `guid` = 12304;

DELETE FROM `creature_addon` WHERE `guid` = 9998008;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998008, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998009;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998009, 997104, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep rare pool named'
FROM `creature`
WHERE `guid` = 12304;

DELETE FROM `creature_addon` WHERE `guid` = 9998009;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998009, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998010;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998010, 997105, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep giant boss'
FROM `creature`
WHERE `guid` = 12293;

DELETE FROM `creature_addon` WHERE `guid` = 9998010;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998010, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998011;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998011, 997106, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Tiragarde Keep guide'
FROM `creature`
WHERE `guid` = 51807;

DELETE FROM `creature_addon` WHERE `guid` = 9998011;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998011, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99980060;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`,
    `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`,
    `wpguid`
)
SELECT
    99980060, `point`, `position_x`, `position_y`,
    `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, 100,
    `wpguid`
FROM `waypoint_data`
WHERE `id` = 129980;

DELETE FROM `pool_template` WHERE `entry` = 997100;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997100, 1, 'Old School Tiragarde Keep rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998008, 9998009);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998008, 997100, 80, 'Ordinary camp occupant'),
(9998009, 997100, 20, 'Rare named replacement');

-- Echo Isles Ruins: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997110, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Hexed Ruin Guard', 'Echo Isles Ruins',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997110, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3207
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997110;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997110, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3207;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997110;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997110, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3207;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997110 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997110, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3207 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997111, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Isle Voodoo Caster', 'Echo Isles Ruins',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997111, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3206
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997111;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997111, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3206;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997111;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997111, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3206;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997111 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997111, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3206 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997112, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Echo Hex Patrol', 'Echo Isles Ruins',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997112, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3207
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997112;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997112, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3207;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997112;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997112, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3207;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997112 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997112, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3207 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997113, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Ruin Hexkeeper', 'Echo Isles Ruins',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997113, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3205
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997113;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997113, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3205;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997113;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997113, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3205;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997113 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997113, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3205 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997114, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Zalazane''s Shadow', 'Echo Isles Ruins',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997114, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3205
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997114;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997114, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3205;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997114;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997114, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3205;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997114 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997114, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3205 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997115, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Hexbound Troll', 'Echo Isles Ruins',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997115, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 3205
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997115;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997115, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 3205;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997115;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997115, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 3205;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997115 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997115, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 3205 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

DELETE FROM `creature_text` WHERE `CreatureID` = 997115;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997115, 0, 0, 'Giant Hexbound Troll roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997115 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997115, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997115, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998110 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998110, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997115, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998110, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 7289, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997116, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Echo Isles Trail Scout', 'Old School public expedition',
    `IconName`, 997116, 9, 9,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 40204
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997116;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997116, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 40204;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997116;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997116, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 40204;

DELETE FROM `npc_text` WHERE `ID` = 997116;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997116, 'Echo Isles Ruins is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Echo Isles Ruins is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997116;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997116, 997116);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994010, `class`, `subclass`, `SoundOverrideSubclass`,
    'Ruin Leather Boots', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 796
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994011, `class`, `subclass`, `SoundOverrideSubclass`,
    'Hexkeeper''s Kindle Staff', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 202581
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994012, `class`, `subclass`, `SoundOverrideSubclass`,
    'Shadow''s Ritual Staff', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 354083
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994013, `class`, `subclass`, `SoundOverrideSubclass`,
    'Hexbound Gloves', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 202580
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994014, `class`, `subclass`, `SoundOverrideSubclass`,
    'Giant Troll Pike', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2075201
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994015, `class`, `subclass`, `SoundOverrideSubclass`,
    'Echo Spirit Robe', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1155734
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997110;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997110, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997110, 765, 0, 35, 0, 1, 0, 1, 2),
    (997110, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997110, 994010, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997111;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997111, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997111, 765, 0, 35, 0, 1, 0, 1, 2),
    (997111, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997111, 994010, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997112;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997112, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997112, 765, 0, 35, 0, 1, 0, 1, 2),
    (997112, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997112, 994010, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997113;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997113, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997113, 765, 0, 35, 0, 1, 0, 1, 2),
    (997113, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997113, 994011, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997114;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997114, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997114, 765, 0, 35, 0, 1, 0, 1, 2),
    (997114, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997114, 994012, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997115;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997115, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997115, 765, 0, 35, 0, 1, 0, 1, 2),
    (997115, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997115, 994013, 0, 30, 0, 1, 0, 1, 1),
    (997115, 994014, 0, 30, 0, 1, 0, 1, 1),
    (997115, 994015, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998100;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998100, 997110, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins ordinary'
FROM `creature`
WHERE `guid` = 13018;

DELETE FROM `creature_addon` WHERE `guid` = 9998100;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998100, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998101;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998101, 997111, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins ordinary'
FROM `creature`
WHERE `guid` = 13021;

DELETE FROM `creature_addon` WHERE `guid` = 9998101;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998101, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998102;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998102, 997110, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins ordinary'
FROM `creature`
WHERE `guid` = 13030;

DELETE FROM `creature_addon` WHERE `guid` = 9998102;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998102, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998103;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998103, 997111, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins ordinary'
FROM `creature`
WHERE `guid` = 13039;

DELETE FROM `creature_addon` WHERE `guid` = 9998103;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998103, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998104;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998104, 997110, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins ordinary'
FROM `creature`
WHERE `guid` = 13007;

DELETE FROM `creature_addon` WHERE `guid` = 9998104;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998104, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998105;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998105, 997111, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins ordinary'
FROM `creature`
WHERE `guid` = 6457;

DELETE FROM `creature_addon` WHERE `guid` = 9998105;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998105, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998106;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998106, 997112, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 0.0, `position_y` + 0.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins patrol'
FROM `creature`
WHERE `guid` = 13026;

DELETE FROM `creature_addon` WHERE `guid` = 9998106;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998106, 99981060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998107;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998107, 997113, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins leader'
FROM `creature`
WHERE `guid` = 13027;

DELETE FROM `creature_addon` WHERE `guid` = 9998107;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998107, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998108;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998108, 997110, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins rare pool ordinary'
FROM `creature`
WHERE `guid` = 13020;

DELETE FROM `creature_addon` WHERE `guid` = 9998108;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998108, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998109;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998109, 997114, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins rare pool named'
FROM `creature`
WHERE `guid` = 13020;

DELETE FROM `creature_addon` WHERE `guid` = 9998109;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998109, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998110;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998110, 997115, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins giant boss'
FROM `creature`
WHERE `guid` = 13036;

DELETE FROM `creature_addon` WHERE `guid` = 9998110;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998110, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998111;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998111, 997116, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Echo Isles Ruins guide'
FROM `creature`
WHERE `guid` = 208921;

DELETE FROM `creature_addon` WHERE `guid` = 9998111;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998111, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99981060;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`,
    `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`,
    `wpguid`
)
SELECT
    99981060, `point`, `position_x`, `position_y`,
    `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, 100,
    `wpguid`
FROM `waypoint_data`
WHERE `id` = 130260;

DELETE FROM `pool_template` WHERE `entry` = 997101;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997101, 1, 'Old School Echo Isles Ruins rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998108, 9998109);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998108, 997101, 80, 'Ordinary camp occupant'),
(9998109, 997101, 20, 'Rare named replacement');

-- Agamand Mills: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997120, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Mill Rattleguard', 'Agamand Mills',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997120, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1520
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997120;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997120, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1520;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997120;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997120, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1520;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997121, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Mill Bonecaster', 'Agamand Mills',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997121, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1522
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997121;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997121, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1522;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997121;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997121, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1522;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997121 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997121, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1522 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997122, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Agamand Grave Patrol', 'Agamand Mills',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997122, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1520
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997122;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997122, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1520;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997122;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997122, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1520;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997123, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Gregor''s Bonewarden', 'Agamand Mills',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997123, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1654
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997123;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997123, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1654;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997123;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997123, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1654;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997124, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Nissa''s Revenant', 'Agamand Mills',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997124, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1656
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997124;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997124, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1656;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997124;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997124, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1656;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997125, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Agamand Boneguard', 'Agamand Mills',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997125, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1654
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997125;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997125, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1654;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997125;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997125, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1654;

DELETE FROM `creature_text` WHERE `CreatureID` = 997125;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997125, 0, 0, 'Giant Agamand Boneguard roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997125 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997125, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997125, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998210 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998210, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997125, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998210, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 13322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997126, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Agamand Road Scout', 'Old School public expedition',
    `IconName`, 997126, 8, 8,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 749136
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997126;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997126, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 749136;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997126;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997126, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 749136;

DELETE FROM `npc_text` WHERE `ID` = 997126;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997126, 'Agamand Mills is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Agamand Mills is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997126;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997126, 997126);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994020, `class`, `subclass`, `SoundOverrideSubclass`,
    'Mill Work Gloves', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 793
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994021, `class`, `subclass`, `SoundOverrideSubclass`,
    'Bonewarden''s Vestments', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2063859
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994022, `class`, `subclass`, `SoundOverrideSubclass`,
    'Revenant Mace', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 515016
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994023, `class`, `subclass`, `SoundOverrideSubclass`,
    'Boneguard Trousers', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2067450
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994024, `class`, `subclass`, `SoundOverrideSubclass`,
    'Agamand Reaping Polearm', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2074505
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994025, `class`, `subclass`, `SoundOverrideSubclass`,
    'Gravekeeper''s Robe', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1155899
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997120;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997120, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997120, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997120, 159, 0, 25, 0, 1, 0, 1, 2),
    (997120, 994020, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997121;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997121, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997121, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997121, 159, 0, 25, 0, 1, 0, 1, 2),
    (997121, 994020, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997122;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997122, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997122, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997122, 159, 0, 25, 0, 1, 0, 1, 2),
    (997122, 994020, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997123;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997123, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997123, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997123, 159, 0, 25, 0, 1, 0, 1, 2),
    (997123, 994021, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997124;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997124, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997124, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997124, 159, 0, 25, 0, 1, 0, 1, 2),
    (997124, 994022, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997125;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997125, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997125, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997125, 159, 0, 25, 0, 1, 0, 1, 2),
    (997125, 994023, 0, 30, 0, 1, 0, 1, 1),
    (997125, 994024, 0, 30, 0, 1, 0, 1, 1),
    (997125, 994025, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998200;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998200, 997120, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills ordinary'
FROM `creature`
WHERE `guid` = 45010;

DELETE FROM `creature_addon` WHERE `guid` = 9998200;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998200, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998201;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998201, 997121, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills ordinary'
FROM `creature`
WHERE `guid` = 44066;

DELETE FROM `creature_addon` WHERE `guid` = 9998201;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998201, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998202;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998202, 997120, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills ordinary'
FROM `creature`
WHERE `guid` = 31926;

DELETE FROM `creature_addon` WHERE `guid` = 9998202;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998202, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998203;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998203, 997121, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills ordinary'
FROM `creature`
WHERE `guid` = 41936;

DELETE FROM `creature_addon` WHERE `guid` = 9998203;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998203, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998204;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998204, 997120, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills ordinary'
FROM `creature`
WHERE `guid` = 38437;

DELETE FROM `creature_addon` WHERE `guid` = 9998204;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998204, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998205;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998205, 997121, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills ordinary'
FROM `creature`
WHERE `guid` = 44920;

DELETE FROM `creature_addon` WHERE `guid` = 9998205;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998205, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998206;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998206, 997122, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 0.0, `position_y` + 0.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills patrol'
FROM `creature`
WHERE `guid` = 44626;

DELETE FROM `creature_addon` WHERE `guid` = 9998206;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998206, 99982060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998207;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998207, 997123, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills leader'
FROM `creature`
WHERE `guid` = 44970;

DELETE FROM `creature_addon` WHERE `guid` = 9998207;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998207, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998208;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998208, 997120, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills rare pool ordinary'
FROM `creature`
WHERE `guid` = 44622;

DELETE FROM `creature_addon` WHERE `guid` = 9998208;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998208, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998209;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998209, 997124, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills rare pool named'
FROM `creature`
WHERE `guid` = 44622;

DELETE FROM `creature_addon` WHERE `guid` = 9998209;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998209, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998210;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998210, 997125, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills giant boss'
FROM `creature`
WHERE `guid` = 42003;

DELETE FROM `creature_addon` WHERE `guid` = 9998210;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998210, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998211;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998211, 997126, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Agamand Mills guide'
FROM `creature`
WHERE `guid` = 9010612;

DELETE FROM `creature_addon` WHERE `guid` = 9998211;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998211, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99982060;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`,
    `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`,
    `wpguid`
)
SELECT
    99982060, `point`, `position_x`, `position_y`,
    `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, 100,
    `wpguid`
FROM `waypoint_data`
WHERE `id` = 446260;

DELETE FROM `pool_template` WHERE `entry` = 997102;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997102, 1, 'Old School Agamand Mills rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998208, 9998209);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998208, 997102, 80, 'Ordinary camp occupant'),
(9998209, 997102, 20, 'Rare named replacement');

-- Scarlet Outpost: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997130, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Scarlet Outpost Guard', 'Scarlet Outpost',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997130, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 162859
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997130;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997130, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 162859;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997130;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997130, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 162859;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997131, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Scarlet Outpost Pyromancer', 'Scarlet Outpost',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997131, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 162860
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997131;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997131, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 162860;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997131;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997131, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 162860;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997131 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997131, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 162860 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997132, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Scarlet Flag Patrol', 'Scarlet Outpost',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997132, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 162861
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997132;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997132, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 162861;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997132;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997132, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 162861;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997133, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Outpost Standard Bearer', 'Scarlet Outpost',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997133, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1535
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997133;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997133, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1535;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997133;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997133, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1535;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997133 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997133, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1535 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997134, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Scarlet Ember Confessor', 'Scarlet Outpost',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997134, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1536
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997134;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997134, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1536;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997134;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997134, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1536;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997134 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997134, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1536 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997135, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Scarlet Pyre Captain', 'Scarlet Outpost',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997135, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1535
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997135;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997135, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1535;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997135;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997135, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1535;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997135 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997135, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1535 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

DELETE FROM `creature_text` WHERE `CreatureID` = 997135;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997135, 0, 0, 'Giant Scarlet Pyre Captain roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997135 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997135, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997135, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998310 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998310, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997135, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998310, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997136, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Scarlet Outpost Scout', 'Old School public expedition',
    `IconName`, 997136, 9, 9,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 2210
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997136;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997136, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 2210;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997136;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997136, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 2210;

DELETE FROM `npc_text` WHERE `ID` = 997136;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997136, 'Scarlet Outpost is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Scarlet Outpost is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997136;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997136, 997136);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994030, `class`, `subclass`, `SoundOverrideSubclass`,
    'Outpost Chain Gloves', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2403
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994031, `class`, `subclass`, `SoundOverrideSubclass`,
    'Bearer''s Insignia', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 515020
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994032, `class`, `subclass`, `SoundOverrideSubclass`,
    'Ember Confessor Staff', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 202581
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994033, `class`, `subclass`, `SoundOverrideSubclass`,
    'Pyre Captain Pauldrons', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2061194
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994034, `class`, `subclass`, `SoundOverrideSubclass`,
    'Giant Captain Barrier', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2078022
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994035, `class`, `subclass`, `SoundOverrideSubclass`,
    'Scarlet Oath Longsword', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 8), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1153550
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997130;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997130, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997130, 2996, 0, 35, 0, 1, 0, 1, 2),
    (997130, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997130, 994030, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997131;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997131, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997131, 2996, 0, 35, 0, 1, 0, 1, 2),
    (997131, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997131, 994030, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997132;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997132, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997132, 2996, 0, 35, 0, 1, 0, 1, 2),
    (997132, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997132, 994030, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997133;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997133, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997133, 2996, 0, 35, 0, 1, 0, 1, 2),
    (997133, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997133, 994031, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997134;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997134, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997134, 2996, 0, 35, 0, 1, 0, 1, 2),
    (997134, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997134, 994032, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997135;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997135, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997135, 2996, 0, 35, 0, 1, 0, 1, 2),
    (997135, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997135, 994033, 0, 30, 0, 1, 0, 1, 1),
    (997135, 994034, 0, 30, 0, 1, 0, 1, 1),
    (997135, 994035, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998300;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998300, 997130, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost ordinary'
FROM `creature`
WHERE `guid` = 9010417;

DELETE FROM `creature_addon` WHERE `guid` = 9998300;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998300, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998301;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998301, 997131, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost ordinary'
FROM `creature`
WHERE `guid` = 9010422;

DELETE FROM `creature_addon` WHERE `guid` = 9998301;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998301, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998302;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998302, 997130, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost ordinary'
FROM `creature`
WHERE `guid` = 9010424;

DELETE FROM `creature_addon` WHERE `guid` = 9998302;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998302, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998303;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998303, 997131, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost ordinary'
FROM `creature`
WHERE `guid` = 9010419;

DELETE FROM `creature_addon` WHERE `guid` = 9998303;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998303, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998304;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998304, 997130, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost ordinary'
FROM `creature`
WHERE `guid` = 9010420;

DELETE FROM `creature_addon` WHERE `guid` = 9998304;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998304, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998305;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998305, 997131, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost ordinary'
FROM `creature`
WHERE `guid` = 9010421;

DELETE FROM `creature_addon` WHERE `guid` = 9998305;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998305, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998306;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998306, 997132, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost patrol'
FROM `creature`
WHERE `guid` = 9010415;

DELETE FROM `creature_addon` WHERE `guid` = 9998306;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998306, 99983060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998307;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998307, 997133, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost leader'
FROM `creature`
WHERE `guid` = 9010423;

DELETE FROM `creature_addon` WHERE `guid` = 9998307;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998307, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998308;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998308, 997130, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost rare pool ordinary'
FROM `creature`
WHERE `guid` = 9010425;

DELETE FROM `creature_addon` WHERE `guid` = 9998308;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998308, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998309;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998309, 997134, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost rare pool named'
FROM `creature`
WHERE `guid` = 9010425;

DELETE FROM `creature_addon` WHERE `guid` = 9998309;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998309, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998310;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998310, 997135, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost giant boss'
FROM `creature`
WHERE `guid` = 9010426;

DELETE FROM `creature_addon` WHERE `guid` = 9998310;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998310, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998311;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998311, 997136, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Scarlet Outpost guide'
FROM `creature`
WHERE `guid` = 29783;

DELETE FROM `creature_addon` WHERE `guid` = 9998311;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998311, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99983060;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(99983060, 1, 2449.00, 194.00, 34.17, 0, 0, 0, 0, 0, 0, 100, 0),
(99983060, 2, 2433.33, 181.62, 29.48, 0, 0, 0, 0, 0, 0, 100, 0),
(99983060, 3, 2463.00, 172.00, 29.37, 0, 0, 0, 0, 0, 0, 100, 0),
(99983060, 4, 2449.00, 194.00, 34.17, 0, 0, 0, 0, 0, 0, 100, 0);

DELETE FROM `pool_template` WHERE `entry` = 997103;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997103, 1, 'Old School Scarlet Outpost rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998308, 9998309);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998308, 997103, 80, 'Ordinary camp occupant'),
(9998309, 997103, 20, 'Rare named replacement');

-- Elwynn Kobold Mine: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997140, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Deepvein Miner', 'Elwynn Kobold Mine',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997140, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 40
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997140;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997140, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 40;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997140;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997140, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 40;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997140 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997140, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 40 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997141, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Deepvein Geomancer', 'Elwynn Kobold Mine',
    `IconName`, 0, 8, 8,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997141, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 476
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997141;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997141, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 476;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997141;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997141, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 476;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997141 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997141, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 476 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997142, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Kobold Tunnel Patrol', 'Elwynn Kobold Mine',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997142, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 40
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997142;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997142, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 40;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997142;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997142, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 40;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997142 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997142, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 40 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997143, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Goldtooth''s Foreman', 'Elwynn Kobold Mine',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997143, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 327
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997143;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997143, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 327;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997143;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997143, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 327;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997144, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Deepflame Prospector', 'Elwynn Kobold Mine',
    `IconName`, 0, 9, 9,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997144, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 327
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997144;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997144, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 327;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997144;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997144, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 327;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997145, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Goldtooth Excavator', 'Elwynn Kobold Mine',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997145, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 327
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997145;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997145, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 327;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997145;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997145, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 327;

DELETE FROM `creature_text` WHERE `CreatureID` = 997145;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997145, 0, 0, 'Giant Goldtooth Excavator roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997145 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997145, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997145, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998410 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998410, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997145, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998410, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997146, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Elwynn Mine Surveyor', 'Old School public expedition',
    `IconName`, 997146, 8, 8,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 255
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997146;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997146, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 255;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997146;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997146, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 255;

DELETE FROM `npc_text` WHERE `ID` = 997146;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997146, 'Elwynn Kobold Mine is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Elwynn Kobold Mine is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997146;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997146, 997146);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994040, `class`, `subclass`, `SoundOverrideSubclass`,
    'Miner''s Leather Boots', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 796
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994041, `class`, `subclass`, `SoundOverrideSubclass`,
    'Foreman''s Malachite Vest', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1161747
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994042, `class`, `subclass`, `SoundOverrideSubclass`,
    'Prospector''s Blade', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 500661
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994043, `class`, `subclass`, `SoundOverrideSubclass`,
    'Excavator Treads', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1161612
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994044, `class`, `subclass`, `SoundOverrideSubclass`,
    'Giant Excavator Longsword', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1153549
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994045, `class`, `subclass`, `SoundOverrideSubclass`,
    'Deepflame Shortsword', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 7), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1161739
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997140;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997140, 2770, 0, 55, 0, 1, 0, 1, 3),
    (997140, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997140, 159, 0, 25, 0, 1, 0, 1, 2),
    (997140, 994040, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997141;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997141, 2770, 0, 55, 0, 1, 0, 1, 3),
    (997141, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997141, 159, 0, 25, 0, 1, 0, 1, 2),
    (997141, 994040, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997142;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997142, 2770, 0, 55, 0, 1, 0, 1, 3),
    (997142, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997142, 159, 0, 25, 0, 1, 0, 1, 2),
    (997142, 994040, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997143;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997143, 2770, 0, 55, 0, 1, 0, 1, 3),
    (997143, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997143, 159, 0, 25, 0, 1, 0, 1, 2),
    (997143, 994041, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997144;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997144, 2770, 0, 55, 0, 1, 0, 1, 3),
    (997144, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997144, 159, 0, 25, 0, 1, 0, 1, 2),
    (997144, 994042, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997145;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997145, 2770, 0, 55, 0, 1, 0, 1, 3),
    (997145, 2835, 0, 35, 0, 1, 0, 1, 2),
    (997145, 159, 0, 25, 0, 1, 0, 1, 2),
    (997145, 994043, 0, 30, 0, 1, 0, 1, 1),
    (997145, 994044, 0, 30, 0, 1, 0, 1, 1),
    (997145, 994045, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998400;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998400, 997140, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine ordinary'
FROM `creature`
WHERE `guid` = 80628;

DELETE FROM `creature_addon` WHERE `guid` = 9998400;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998400, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998401;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998401, 997141, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine ordinary'
FROM `creature`
WHERE `guid` = 80614;

DELETE FROM `creature_addon` WHERE `guid` = 9998401;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998401, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998402;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998402, 997140, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine ordinary'
FROM `creature`
WHERE `guid` = 80630;

DELETE FROM `creature_addon` WHERE `guid` = 9998402;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998402, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998403;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998403, 997141, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine ordinary'
FROM `creature`
WHERE `guid` = 80639;

DELETE FROM `creature_addon` WHERE `guid` = 9998403;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998403, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998404;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998404, 997140, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine ordinary'
FROM `creature`
WHERE `guid` = 80617;

DELETE FROM `creature_addon` WHERE `guid` = 9998404;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998404, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998405;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998405, 997141, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine ordinary'
FROM `creature`
WHERE `guid` = 80605;

DELETE FROM `creature_addon` WHERE `guid` = 9998405;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998405, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998406;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998406, 997142, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 0.0, `position_y` + 0.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine patrol'
FROM `creature`
WHERE `guid` = 80634;

DELETE FROM `creature_addon` WHERE `guid` = 9998406;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998406, 99984060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998407;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998407, 997143, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine leader'
FROM `creature`
WHERE `guid` = 80629;

DELETE FROM `creature_addon` WHERE `guid` = 9998407;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998407, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998408;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998408, 997140, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine rare pool ordinary'
FROM `creature`
WHERE `guid` = 80620;

DELETE FROM `creature_addon` WHERE `guid` = 9998408;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998408, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998409;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998409, 997144, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine rare pool named'
FROM `creature`
WHERE `guid` = 80620;

DELETE FROM `creature_addon` WHERE `guid` = 9998409;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998409, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998410;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998410, 997145, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine giant boss'
FROM `creature`
WHERE `guid` = 80650;

DELETE FROM `creature_addon` WHERE `guid` = 9998410;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998410, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998411;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998411, 997146, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Elwynn Kobold Mine guide'
FROM `creature`
WHERE `guid` = 80686;

DELETE FROM `creature_addon` WHERE `guid` = 9998411;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998411, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99984060;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`,
    `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`,
    `wpguid`
)
SELECT
    99984060, `point`, `position_x`, `position_y`,
    `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, 100,
    `wpguid`
FROM `waypoint_data`
WHERE `id` = 806340;

DELETE FROM `pool_template` WHERE `entry` = 997104;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997104, 1, 'Old School Elwynn Kobold Mine rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998408, 9998409);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998408, 997104, 80, 'Ordinary camp occupant'),
(9998409, 997104, 20, 'Rare named replacement');

-- Riverpaw Camp: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997150, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Riverpaw Camp Fighter', 'Riverpaw Camp',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997150, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 97
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997150;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997150, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 97;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997150;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997150, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 97;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997151, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Riverpaw Camp Shaman', 'Riverpaw Camp',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997151, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1065
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997151;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997151, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1065;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997151;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997151, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1065;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997151 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997151, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1065 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997152, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Riverpaw Hunting Patrol', 'Riverpaw Camp',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997152, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 478
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997152;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997152, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 478;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997152;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997152, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 478;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997153, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Hogger''s Packmaster', 'Riverpaw Camp',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997153, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 448
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997153;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997153, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 448;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997153;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997153, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 448;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997153 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997153, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 448 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997154, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Riverpaw Bonegnaw', 'Riverpaw Camp',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997154, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 448
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997154;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997154, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 448;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997154;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997154, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 448;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997154 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997154, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 448 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997155, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Riverpaw Warleader', 'Riverpaw Camp',
    `IconName`, 0, 12, 12,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997155, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 448
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997155;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997155, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 448;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997155;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997155, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 448;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997155 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997155, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 448 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

DELETE FROM `creature_text` WHERE `CreatureID` = 997155;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997155, 0, 0, 'Giant Riverpaw Warleader roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997155 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997155, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997155, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998510 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998510, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997155, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998510, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 6730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997156, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Riverpaw Camp Scout', 'Old School public expedition',
    `IconName`, 997156, 10, 10,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 252
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997156;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997156, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 252;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997156;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997156, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 252;

DELETE FROM `npc_text` WHERE `ID` = 997156;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997156, 'Riverpaw Camp is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Riverpaw Camp is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997156;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997156, 997156);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994050, `class`, `subclass`, `SoundOverrideSubclass`,
    'Camp Leather Gloves', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 797
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994051, `class`, `subclass`, `SoundOverrideSubclass`,
    'Packmaster Gauntlets', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 202580
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994052, `class`, `subclass`, `SoundOverrideSubclass`,
    'Bonegnaw Belt', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 202568
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994053, `class`, `subclass`, `SoundOverrideSubclass`,
    'Warleader Mask', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 500662
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994054, `class`, `subclass`, `SoundOverrideSubclass`,
    'Giant Warleader Blade', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 500661
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994055, `class`, `subclass`, `SoundOverrideSubclass`,
    'Riverpaw Hide Vest', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1154282
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997150;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997150, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997150, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997150, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997150, 994050, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997151;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997151, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997151, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997151, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997151, 994050, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997152;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997152, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997152, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997152, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997152, 994050, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997153;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997153, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997153, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997153, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997153, 994051, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997154;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997154, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997154, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997154, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997154, 994052, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997155;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997155, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997155, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997155, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997155, 994053, 0, 30, 0, 1, 0, 1, 1),
    (997155, 994054, 0, 30, 0, 1, 0, 1, 1),
    (997155, 994055, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998500;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998500, 997150, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp ordinary'
FROM `creature`
WHERE `guid` = 80516;

DELETE FROM `creature_addon` WHERE `guid` = 9998500;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998500, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998501;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998501, 997151, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp ordinary'
FROM `creature`
WHERE `guid` = 80492;

DELETE FROM `creature_addon` WHERE `guid` = 9998501;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998501, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998502;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998502, 997150, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp ordinary'
FROM `creature`
WHERE `guid` = 80541;

DELETE FROM `creature_addon` WHERE `guid` = 9998502;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998502, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998503;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998503, 997151, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp ordinary'
FROM `creature`
WHERE `guid` = 80533;

DELETE FROM `creature_addon` WHERE `guid` = 9998503;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998503, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998504;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998504, 997150, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp ordinary'
FROM `creature`
WHERE `guid` = 80539;

DELETE FROM `creature_addon` WHERE `guid` = 9998504;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998504, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998505;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998505, 997151, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp ordinary'
FROM `creature`
WHERE `guid` = 80509;

DELETE FROM `creature_addon` WHERE `guid` = 9998505;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998505, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998506;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998506, 997152, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp patrol'
FROM `creature`
WHERE `guid` = 80528;

DELETE FROM `creature_addon` WHERE `guid` = 9998506;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998506, 99985060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998507;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998507, 997153, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp leader'
FROM `creature`
WHERE `guid` = 80532;

DELETE FROM `creature_addon` WHERE `guid` = 9998507;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998507, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998508;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998508, 997150, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp rare pool ordinary'
FROM `creature`
WHERE `guid` = 80490;

DELETE FROM `creature_addon` WHERE `guid` = 9998508;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998508, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998509;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998509, 997154, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp rare pool named'
FROM `creature`
WHERE `guid` = 80490;

DELETE FROM `creature_addon` WHERE `guid` = 9998509;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998509, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998510;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998510, 997155, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp giant boss'
FROM `creature`
WHERE `guid` = 80512;

DELETE FROM `creature_addon` WHERE `guid` = 9998510;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998510, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998511;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998511, 997156, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Riverpaw Camp guide'
FROM `creature`
WHERE `guid` = 80542;

DELETE FROM `creature_addon` WHERE `guid` = 9998511;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998511, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99985060;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(99985060, 1, -9955.76, 548.44, 37.70, 0, 0, 0, 0, 0, 0, 100, 0),
(99985060, 2, -9957.96, 555.83, 37.76, 0, 0, 0, 0, 0, 0, 100, 0),
(99985060, 3, -9977.14, 551.84, 38.01, 0, 0, 0, 0, 0, 0, 100, 0),
(99985060, 4, -9955.76, 548.44, 37.70, 0, 0, 0, 0, 0, 0, 100, 0);

DELETE FROM `pool_template` WHERE `entry` = 997105;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997105, 1, 'Old School Riverpaw Camp rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998508, 9998509);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998508, 997105, 80, 'Ordinary camp occupant'),
(9998509, 997105, 20, 'Rare named replacement');

-- Frostmane Hold: native map/terrain anchors, Old School phase only.

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997160, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Hold Frostmane Fighter', 'Frostmane Hold',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997160, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1120
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997160;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997160, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1120;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997160;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997160, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1120;

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997161, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Hold Shadowcaster', 'Frostmane Hold',
    `IconName`, 0, 10, 10,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997161, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1124
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997161;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997161, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1124;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997161;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997161, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1124;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997161 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997161, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1124 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997162, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Frostmane Ridge Patrol', 'Frostmane Hold',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997162, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1123
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997162;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997162, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1123;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997162;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997162, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1123;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997162 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997162, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1123 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997163, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Snowstrider Captain', 'Frostmane Hold',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997163, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1121
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997163;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997163, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1121;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997163;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997163, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1121;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997163 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997163, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1121 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997164, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Frostmane Hidehunter', 'Frostmane Hold',
    `IconName`, 0, 11, 11,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997164, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1122
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997164;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997164, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1122;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997164;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997164, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1122;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997164 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997164, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1122 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997165, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Giant Frostmane Chieftain', 'Frostmane Hold',
    `IconName`, 0, 12, 12,
    `exp`, `faction`, 0, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    1, `dmgschool`, 1, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 997165, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, 'SmartAI', `MovementType`, `HoverHeight`,
    1, `ManaModifier`, `ArmorModifier`, 1,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 1123
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997165;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997165, `Idx`, `CreatureDisplayID`, 1.45,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 1123;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997165;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997165, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 1123;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997165 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
)
SELECT
    997165, `source_type`, `id`, 0,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`
FROM `smart_scripts`
WHERE `entryorguid` = 1123 AND `source_type` = 0 AND `action_type` = 11 AND `event_type` IN (0, 2, 4, 105);

DELETE FROM `creature_text` WHERE `CreatureID` = 997165;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(997165, 0, 0, 'Giant Frostmane Chieftain roars before a final frenzy!', 16, 0, 100, 0, 0, 0, 0, 0, 'Old School public dungeon warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 997165 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(997165, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn before frenzy'),
(997165, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frenzy after warning');

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9998610 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-9998610, 0, 10, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 997165, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warn and frenzy below 35% health'),
(-9998610, 0, 11, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Recurring native signature ability');

INSERT INTO `creature_template` (
    `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
    `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`,
    `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`,
    `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`,
    `VerifiedBuild`
)
SELECT
    997166, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, 'Frostmane Hold Scout', 'Old School public expedition',
    `IconName`, 997166, 10, 10,
    `exp`, 35, 1, `speed_walk`,
    `speed_run`, `speed_swim`, `speed_flight`, `detection_range`,
    0, `dmgschool`, `DamageModifier`, `BaseAttackTime`,
    `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
    `type`, `type_flags`, 0, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`,
    `maxgold`, '', `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`,
    `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, '', `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = 6886
ON DUPLICATE KEY UPDATE
    `difficulty_entry_1` = VALUES(`difficulty_entry_1`),
    `difficulty_entry_2` = VALUES(`difficulty_entry_2`),
    `difficulty_entry_3` = VALUES(`difficulty_entry_3`),
    `KillCredit1` = VALUES(`KillCredit1`),
    `KillCredit2` = VALUES(`KillCredit2`),
    `name` = VALUES(`name`),
    `subname` = VALUES(`subname`),
    `IconName` = VALUES(`IconName`),
    `gossip_menu_id` = VALUES(`gossip_menu_id`),
    `minlevel` = VALUES(`minlevel`),
    `maxlevel` = VALUES(`maxlevel`),
    `exp` = VALUES(`exp`),
    `faction` = VALUES(`faction`),
    `npcflag` = VALUES(`npcflag`),
    `speed_walk` = VALUES(`speed_walk`),
    `speed_run` = VALUES(`speed_run`),
    `speed_swim` = VALUES(`speed_swim`),
    `speed_flight` = VALUES(`speed_flight`),
    `detection_range` = VALUES(`detection_range`),
    `rank` = VALUES(`rank`),
    `dmgschool` = VALUES(`dmgschool`),
    `DamageModifier` = VALUES(`DamageModifier`),
    `BaseAttackTime` = VALUES(`BaseAttackTime`),
    `RangeAttackTime` = VALUES(`RangeAttackTime`),
    `BaseVariance` = VALUES(`BaseVariance`),
    `RangeVariance` = VALUES(`RangeVariance`),
    `unit_class` = VALUES(`unit_class`),
    `unit_flags` = VALUES(`unit_flags`),
    `unit_flags2` = VALUES(`unit_flags2`),
    `dynamicflags` = VALUES(`dynamicflags`),
    `family` = VALUES(`family`),
    `type` = VALUES(`type`),
    `type_flags` = VALUES(`type_flags`),
    `lootid` = VALUES(`lootid`),
    `pickpocketloot` = VALUES(`pickpocketloot`),
    `skinloot` = VALUES(`skinloot`),
    `PetSpellDataId` = VALUES(`PetSpellDataId`),
    `VehicleId` = VALUES(`VehicleId`),
    `mingold` = VALUES(`mingold`),
    `maxgold` = VALUES(`maxgold`),
    `AIName` = VALUES(`AIName`),
    `MovementType` = VALUES(`MovementType`),
    `HoverHeight` = VALUES(`HoverHeight`),
    `HealthModifier` = VALUES(`HealthModifier`),
    `ManaModifier` = VALUES(`ManaModifier`),
    `ArmorModifier` = VALUES(`ArmorModifier`),
    `ExperienceModifier` = VALUES(`ExperienceModifier`),
    `RacialLeader` = VALUES(`RacialLeader`),
    `movementId` = VALUES(`movementId`),
    `RegenHealth` = VALUES(`RegenHealth`),
    `CreatureImmunitiesId` = VALUES(`CreatureImmunitiesId`),
    `flags_extra` = VALUES(`flags_extra`),
    `ScriptName` = VALUES(`ScriptName`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 997166;
INSERT INTO `creature_template_model` (
    `CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
)
SELECT
    997166, `Idx`, `CreatureDisplayID`, `DisplayScale`,
    `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 6886;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 997166;
INSERT INTO `creature_equip_template` (
    `CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
)
SELECT
    997166, `ID`, `ItemID1`, `ItemID2`,
    `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template`
WHERE `CreatureID` = 6886;

DELETE FROM `npc_text` WHERE `ID` = 997166;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `Probability0`) VALUES
(997166, 'Frostmane Hold is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 'Frostmane Hold is a shared Old School expedition. The outer guards lead toward a more dangerous patrol, a leader and a giant threat. A rare named enemy can replace an ordinary camp occupant. Scout the edges, choose a flank, and place your own camp beyond the patrol route. Water and crafting supplies may come from the enemies; equipment is tied to specific foes.', 1);
DELETE FROM `gossip_menu` WHERE `MenuID` = 997166;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(997166, 997166);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994060, `class`, `subclass`, `SoundOverrideSubclass`,
    'Frostmane Leather Boots', `displayid`, 1, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 796
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994061, `class`, `subclass`, `SoundOverrideSubclass`,
    'Captain''s Cloak', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 500663
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994062, `class`, `subclass`, `SoundOverrideSubclass`,
    'Hidehunter Hammer', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 355515
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994063, `class`, `subclass`, `SoundOverrideSubclass`,
    'Chieftain Footpads', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 202575
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994064, `class`, `subclass`, `SoundOverrideSubclass`,
    'Giant Chieftain Greaves', `displayid`, 3, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 2067693
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

INSERT INTO `item_template` (
    `entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`,
    `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`,
    `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`,
    `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`,
    `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
    `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`,
    `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`,
    `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`,
    `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
    `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`,
    `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`,
    `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`,
    `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`,
    `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`,
    `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`,
    `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`,
    `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`,
    `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`,
    `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`,
    `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`,
    `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`,
    `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`
)
SELECT
    994065, `class`, `subclass`, `SoundOverrideSubclass`,
    'Frostmane Battle Axe', `displayid`, 4, `Flags`,
    `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`,
    `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
    GREATEST(`RequiredLevel`, 9), `RequiredSkill`, `RequiredSkillRank`, `requiredspell`,
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
    `flagsCustom`, `VerifiedBuild`
FROM `item_template`
WHERE `entry` = 1152605
ON DUPLICATE KEY UPDATE
    `class` = VALUES(`class`),
    `subclass` = VALUES(`subclass`),
    `SoundOverrideSubclass` = VALUES(`SoundOverrideSubclass`),
    `name` = VALUES(`name`),
    `displayid` = VALUES(`displayid`),
    `Quality` = VALUES(`Quality`),
    `Flags` = VALUES(`Flags`),
    `FlagsExtra` = VALUES(`FlagsExtra`),
    `BuyCount` = VALUES(`BuyCount`),
    `BuyPrice` = VALUES(`BuyPrice`),
    `SellPrice` = VALUES(`SellPrice`),
    `InventoryType` = VALUES(`InventoryType`),
    `AllowableClass` = VALUES(`AllowableClass`),
    `AllowableRace` = VALUES(`AllowableRace`),
    `ItemLevel` = VALUES(`ItemLevel`),
    `RequiredLevel` = VALUES(`RequiredLevel`),
    `RequiredSkill` = VALUES(`RequiredSkill`),
    `RequiredSkillRank` = VALUES(`RequiredSkillRank`),
    `requiredspell` = VALUES(`requiredspell`),
    `requiredhonorrank` = VALUES(`requiredhonorrank`),
    `RequiredCityRank` = VALUES(`RequiredCityRank`),
    `RequiredReputationFaction` = VALUES(`RequiredReputationFaction`),
    `RequiredReputationRank` = VALUES(`RequiredReputationRank`),
    `maxcount` = VALUES(`maxcount`),
    `stackable` = VALUES(`stackable`),
    `ContainerSlots` = VALUES(`ContainerSlots`),
    `stat_type1` = VALUES(`stat_type1`),
    `stat_value1` = VALUES(`stat_value1`),
    `stat_type2` = VALUES(`stat_type2`),
    `stat_value2` = VALUES(`stat_value2`),
    `stat_type3` = VALUES(`stat_type3`),
    `stat_value3` = VALUES(`stat_value3`),
    `stat_type4` = VALUES(`stat_type4`),
    `stat_value4` = VALUES(`stat_value4`),
    `stat_type5` = VALUES(`stat_type5`),
    `stat_value5` = VALUES(`stat_value5`),
    `stat_type6` = VALUES(`stat_type6`),
    `stat_value6` = VALUES(`stat_value6`),
    `stat_type7` = VALUES(`stat_type7`),
    `stat_value7` = VALUES(`stat_value7`),
    `stat_type8` = VALUES(`stat_type8`),
    `stat_value8` = VALUES(`stat_value8`),
    `stat_type9` = VALUES(`stat_type9`),
    `stat_value9` = VALUES(`stat_value9`),
    `stat_type10` = VALUES(`stat_type10`),
    `stat_value10` = VALUES(`stat_value10`),
    `ScalingStatDistribution` = VALUES(`ScalingStatDistribution`),
    `ScalingStatValue` = VALUES(`ScalingStatValue`),
    `dmg_min1` = VALUES(`dmg_min1`),
    `dmg_max1` = VALUES(`dmg_max1`),
    `dmg_type1` = VALUES(`dmg_type1`),
    `dmg_min2` = VALUES(`dmg_min2`),
    `dmg_max2` = VALUES(`dmg_max2`),
    `dmg_type2` = VALUES(`dmg_type2`),
    `armor` = VALUES(`armor`),
    `holy_res` = VALUES(`holy_res`),
    `fire_res` = VALUES(`fire_res`),
    `nature_res` = VALUES(`nature_res`),
    `frost_res` = VALUES(`frost_res`),
    `shadow_res` = VALUES(`shadow_res`),
    `arcane_res` = VALUES(`arcane_res`),
    `delay` = VALUES(`delay`),
    `ammo_type` = VALUES(`ammo_type`),
    `RangedModRange` = VALUES(`RangedModRange`),
    `spellid_1` = VALUES(`spellid_1`),
    `spelltrigger_1` = VALUES(`spelltrigger_1`),
    `spellcharges_1` = VALUES(`spellcharges_1`),
    `spellppmRate_1` = VALUES(`spellppmRate_1`),
    `spellcooldown_1` = VALUES(`spellcooldown_1`),
    `spellcategory_1` = VALUES(`spellcategory_1`),
    `spellcategorycooldown_1` = VALUES(`spellcategorycooldown_1`),
    `spellid_2` = VALUES(`spellid_2`),
    `spelltrigger_2` = VALUES(`spelltrigger_2`),
    `spellcharges_2` = VALUES(`spellcharges_2`),
    `spellppmRate_2` = VALUES(`spellppmRate_2`),
    `spellcooldown_2` = VALUES(`spellcooldown_2`),
    `spellcategory_2` = VALUES(`spellcategory_2`),
    `spellcategorycooldown_2` = VALUES(`spellcategorycooldown_2`),
    `spellid_3` = VALUES(`spellid_3`),
    `spelltrigger_3` = VALUES(`spelltrigger_3`),
    `spellcharges_3` = VALUES(`spellcharges_3`),
    `spellppmRate_3` = VALUES(`spellppmRate_3`),
    `spellcooldown_3` = VALUES(`spellcooldown_3`),
    `spellcategory_3` = VALUES(`spellcategory_3`),
    `spellcategorycooldown_3` = VALUES(`spellcategorycooldown_3`),
    `spellid_4` = VALUES(`spellid_4`),
    `spelltrigger_4` = VALUES(`spelltrigger_4`),
    `spellcharges_4` = VALUES(`spellcharges_4`),
    `spellppmRate_4` = VALUES(`spellppmRate_4`),
    `spellcooldown_4` = VALUES(`spellcooldown_4`),
    `spellcategory_4` = VALUES(`spellcategory_4`),
    `spellcategorycooldown_4` = VALUES(`spellcategorycooldown_4`),
    `spellid_5` = VALUES(`spellid_5`),
    `spelltrigger_5` = VALUES(`spelltrigger_5`),
    `spellcharges_5` = VALUES(`spellcharges_5`),
    `spellppmRate_5` = VALUES(`spellppmRate_5`),
    `spellcooldown_5` = VALUES(`spellcooldown_5`),
    `spellcategory_5` = VALUES(`spellcategory_5`),
    `spellcategorycooldown_5` = VALUES(`spellcategorycooldown_5`),
    `bonding` = VALUES(`bonding`),
    `description` = VALUES(`description`),
    `PageText` = VALUES(`PageText`),
    `LanguageID` = VALUES(`LanguageID`),
    `PageMaterial` = VALUES(`PageMaterial`),
    `startquest` = VALUES(`startquest`),
    `lockid` = VALUES(`lockid`),
    `Material` = VALUES(`Material`),
    `sheath` = VALUES(`sheath`),
    `RandomProperty` = VALUES(`RandomProperty`),
    `RandomSuffix` = VALUES(`RandomSuffix`),
    `block` = VALUES(`block`),
    `itemset` = VALUES(`itemset`),
    `MaxDurability` = VALUES(`MaxDurability`),
    `area` = VALUES(`area`),
    `Map` = VALUES(`Map`),
    `BagFamily` = VALUES(`BagFamily`),
    `TotemCategory` = VALUES(`TotemCategory`),
    `socketColor_1` = VALUES(`socketColor_1`),
    `socketContent_1` = VALUES(`socketContent_1`),
    `socketColor_2` = VALUES(`socketColor_2`),
    `socketContent_2` = VALUES(`socketContent_2`),
    `socketColor_3` = VALUES(`socketColor_3`),
    `socketContent_3` = VALUES(`socketContent_3`),
    `socketBonus` = VALUES(`socketBonus`),
    `GemProperties` = VALUES(`GemProperties`),
    `RequiredDisenchantSkill` = VALUES(`RequiredDisenchantSkill`),
    `ArmorDamageModifier` = VALUES(`ArmorDamageModifier`),
    `duration` = VALUES(`duration`),
    `ItemLimitCategory` = VALUES(`ItemLimitCategory`),
    `HolidayId` = VALUES(`HolidayId`),
    `ScriptName` = VALUES(`ScriptName`),
    `DisenchantID` = VALUES(`DisenchantID`),
    `FoodType` = VALUES(`FoodType`),
    `minMoneyLoot` = VALUES(`minMoneyLoot`),
    `maxMoneyLoot` = VALUES(`maxMoneyLoot`),
    `flagsCustom` = VALUES(`flagsCustom`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997160;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997160, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997160, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997160, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997160, 994060, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997161;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997161, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997161, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997161, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997161, 994060, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997162;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997162, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997162, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997162, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997162, 994060, 0, 8, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997163;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997163, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997163, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997163, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997163, 994061, 0, 30, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997164;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997164, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997164, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997164, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997164, 994062, 0, 35, 0, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE `Entry` = 997165;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
    (997165, 2589, 0, 55, 0, 1, 0, 1, 3),
    (997165, 2318, 0, 35, 0, 1, 0, 1, 2),
    (997165, 1179, 0, 25, 0, 1, 0, 1, 2),
    (997165, 994063, 0, 30, 0, 1, 0, 1, 1),
    (997165, 994064, 0, 30, 0, 1, 0, 1, 1),
    (997165, 994065, 0, 3, 0, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `guid` = 9998600;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998600, 997160, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold ordinary'
FROM `creature`
WHERE `guid` = 2907;

DELETE FROM `creature_addon` WHERE `guid` = 9998600;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998600, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998601;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998601, 997161, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold ordinary'
FROM `creature`
WHERE `guid` = 2950;

DELETE FROM `creature_addon` WHERE `guid` = 9998601;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998601, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998602;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998602, 997160, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold ordinary'
FROM `creature`
WHERE `guid` = 2931;

DELETE FROM `creature_addon` WHERE `guid` = 9998602;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998602, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998603;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998603, 997161, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold ordinary'
FROM `creature`
WHERE `guid` = 2927;

DELETE FROM `creature_addon` WHERE `guid` = 9998603;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998603, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998604;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998604, 997160, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold ordinary'
FROM `creature`
WHERE `guid` = 2923;

DELETE FROM `creature_addon` WHERE `guid` = 9998604;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998604, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998605;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998605, 997161, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    360, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold ordinary'
FROM `creature`
WHERE `guid` = 2956;

DELETE FROM `creature_addon` WHERE `guid` = 9998605;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998605, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998606;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998606, 997162, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 0.0, `position_y` + 0.0, `position_z`, `orientation`,
    450, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 2, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold patrol'
FROM `creature`
WHERE `guid` = 2942;

DELETE FROM `creature_addon` WHERE `guid` = 9998606;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998606, 99986060, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998607;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998607, 997163, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold leader'
FROM `creature`
WHERE `guid` = 2940;

DELETE FROM `creature_addon` WHERE `guid` = 9998607;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998607, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998608;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998608, 997160, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    720, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold rare pool ordinary'
FROM `creature`
WHERE `guid` = 2946;

DELETE FROM `creature_addon` WHERE `guid` = 9998608;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998608, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998609;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998609, 997164, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    900, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold rare pool named'
FROM `creature`
WHERE `guid` = 2946;

DELETE FROM `creature_addon` WHERE `guid` = 9998609;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998609, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998610;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998610, 997165, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    1200, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 0, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold giant boss'
FROM `creature`
WHERE `guid` = 2929;

DELETE FROM `creature_addon` WHERE `guid` = 9998610;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998610, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature` WHERE `guid` = 9998611;
INSERT INTO `creature` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
    `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
    `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
    `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`
)
SELECT
    9998611, 997166, `map`, `zoneId`,
    `areaId`, `spawnMask`, 1073741824, `equipment_id`,
    `position_x` + 4.0, `position_y` + 4.0, `position_z`, `orientation`,
    300, 0, `currentwaypoint`, `curhealth`,
    `curmana`, 0, 1, 0,
    0, '', `VerifiedBuild`, `CreateObject`,
    'Old School Frostmane Hold guide'
FROM `creature`
WHERE `guid` = 2901;

DELETE FROM `creature_addon` WHERE `guid` = 9998611;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9998611, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = 99986060;
INSERT INTO `waypoint_data` (
    `id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`,
    `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`,
    `wpguid`
)
SELECT
    99986060, `point`, `position_x`, `position_y`,
    `position_z`, `orientation`, `velocity`, `delay`,
    `smoothTransition`, `move_type`, 0, 100,
    `wpguid`
FROM `waypoint_data`
WHERE `id` = 29420;

DELETE FROM `pool_template` WHERE `entry` = 997106;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(997106, 1, 'Old School Frostmane Hold rare replacement');
DELETE FROM `pool_creature` WHERE `guid` IN (9998608, 9998609);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9998608, 997106, 80, 'Ordinary camp occupant'),
(9998609, 997106, 20, 'Rare named replacement');
