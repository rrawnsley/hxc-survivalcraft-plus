-- Complete the authored AI for seven phased public-dungeon roles and remove
-- missing equipment references on three Agamand skeletal spawns.

UPDATE `creature_template`
SET `AIName` = ''
WHERE `entry` IN (997120, 997130, 997150, 997160)
    AND `AIName` = 'SmartAI';

DELETE FROM `smart_scripts`
WHERE `entryorguid` IN (997122, 997123, 997124, 997132, 997143, 997144, 997152)
    AND `source_type` = 0;

INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`
) VALUES
    (997122, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 14000, 19000, 0, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Agamand Grave Patrol - Pierce Armor'),
    (997123, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 15000, 20000, 0, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Gregor Bonewarden - Pierce Armor'),
    (997124, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 7000, 10000, 0, 0, 11, 13322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Nissa Revenant - Frostbolt'),
    (997132, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 18000, 24000, 0, 0, 11, 3238, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Scarlet Flag Patrol - Nimble Reflexes'),
    (997143, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 14000, 19000, 0, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Goldtooth Foreman - Pierce Armor'),
    (997144, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 6000, 9000, 0, 0, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Deepflame Prospector - Fireball'),
    (997152, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 15000, 20000, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Old School Riverpaw Hunting Patrol - Thrash');

UPDATE `creature`
SET `equipment_id` = 0
WHERE (`guid` = 9998207 AND `id` = 997123)
    OR (`guid` = 9998209 AND `id` = 997124)
    OR (`guid` = 9998210 AND `id` = 997125);
