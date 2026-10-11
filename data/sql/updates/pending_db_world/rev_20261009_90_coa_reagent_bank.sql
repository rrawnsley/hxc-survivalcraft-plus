DELETE FROM `creature_template_model` WHERE `CreatureID` = 290011;
DELETE FROM `creature_template` WHERE `entry` = 290011;

INSERT INTO `creature_template` (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `rank`, `dmgschool`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `AIName`, `MovementType`, `HoverHeight`, `RacialLeader`, `movementId`, `RegenHealth`, `flags_extra`, `ScriptName`) VALUES
(290011, 'Ling', 'Reagent Banker', NULL, 0, 6, 6, 0, 35, 1, 0, 0, 2000, 0, 1, 0, 7, 138412032, 0, 0, 0, '', 0, 1, 0, 0, 1, 2, 'npc_reagent_banker');

DELETE FROM `creature_template_model` WHERE `CreatureID` = 290011 AND `Idx` = 0;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(290011, 0, 15965, 1.0, 1.0, NULL);

DELETE FROM `creature` WHERE `id` = 290011 OR `guid` IN (5500920, 5500921);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `Comment`) VALUES
(5500920, 290011, 0, 1519, 5148, 1, 1, 0, -8829.2, 620.0, 94.10, 3.927, 300, 0, 0, 0, 'mod-reagent-bank Ling Stormwind'),
(5500921, 290011, 1, 1637, 1637, 1, 1, 0, 1640.0, -4428.2, 15.55, 5.393, 300, 0, 0, 0, 'mod-reagent-bank Ling Orgrimmar');
