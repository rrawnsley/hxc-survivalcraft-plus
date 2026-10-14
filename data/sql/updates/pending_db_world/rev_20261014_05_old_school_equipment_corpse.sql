INSERT INTO `creature_template`
(`entry`, `name`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `type`, `unit_flags`, `ScriptName`)
VALUES (996900, 'Fallen Adventurer', 1, 1, 35, 1, 7, 770, 'coa_old_school_equipment_corpse')
ON DUPLICATE KEY UPDATE
`name` = VALUES(`name`), `faction` = VALUES(`faction`), `npcflag` = VALUES(`npcflag`),
`unit_flags` = VALUES(`unit_flags`), `ScriptName` = VALUES(`ScriptName`);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 996900;
INSERT INTO `creature_template_model`
(`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`)
VALUES (996900, 0, 10045, 1, 1)
ON DUPLICATE KEY UPDATE `CreatureDisplayID` = VALUES(`CreatureDisplayID`),
`DisplayScale` = VALUES(`DisplayScale`), `Probability` = VALUES(`Probability`);
