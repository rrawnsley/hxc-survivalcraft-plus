UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 996776;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 996776 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9996776 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(-9996776, 0, 100, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 0, 80, 99677658, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(-9996776, 0, 101, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99677658 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(99677658, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99677658, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99677658, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `creature_text` WHERE `CreatureID` = 996776 AND `GroupID` = 50;
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
`BroadcastTextId`, `TextRange`, `comment`) VALUES
(996776, 50, 0, 'Rattlebone rattles violently! Its frenzy is about to begin.' , 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School encounter warning' );

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 996784;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 996784 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9996784 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(-9996784, 0, 100, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 0, 80, 99678458, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(-9996784, 0, 101, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99678458 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(99678458, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99678458, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99678458, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 28, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `creature_text` WHERE `CreatureID` = 996784 AND `GroupID` = 50;
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
`BroadcastTextId`, `TextRange`, `comment`) VALUES
(996784, 50, 0, 'Brambletusk paws the earth! Its frenzy is about to begin.' , 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School encounter warning' );

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 996833;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 996833 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9996833 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(-9996833, 0, 100, 0, 0, 0, 100, 0, 8000, 10000, 30000, 35000, 0, 0, 80, 99683358, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
    0, 0, 'Old School announced encounter moment' );

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99683358 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(99683358, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99683358, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 6278, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `creature_text` WHERE `CreatureID` = 996833 AND `GroupID` = 50;
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
`BroadcastTextId`, `TextRange`, `comment`) VALUES
(996833, 50, 0, 'Zarzoth gathers choking spores for a poisonous cast!' , 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School encounter warning' );

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 996838;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 996838 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9996838 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(-9996838, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1800000, 1800000, 0, 0, 11, 12544, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 'Apprentice Althea' ),
(-9996838, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 13322, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Apprentice Althea' ),
(-9996838, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    'Apprentice Althea' ),
(-9996838, 0, 100, 0, 2, 0, 100, 1, 0, 35, 0, 0, 0, 0, 80, 99683858, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99683858 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(99683858, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99683858, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 8005, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `creature_text` WHERE `CreatureID` = 996838 AND `GroupID` = 50;
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
`BroadcastTextId`, `TextRange`, `comment`) VALUES
(996838, 50, 0, 'Althea gathers restorative magic. Interrupt her healing!' , 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School encounter warning' );

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 996839;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 996839 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9996839 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(-9996839, 0, 0, 0, 4, 0, 10, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brannik Tunnelshot'
    ),
(-9996839, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2300, 2700, 0, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Brannik Tunnelshot' ),
(-9996839, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    'Brannik Tunnelshot' ),
(-9996839, 0, 100, 0, 0, 0, 100, 0, 12000, 15000, 25000, 30000, 0, 0, 80, 99683958, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
    0, 0, 'Old School announced encounter moment' );

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99683958 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(99683958, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99683958, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 6660, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `creature_text` WHERE `CreatureID` = 996839 AND `GroupID` = 50;
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
`BroadcastTextId`, `TextRange`, `comment`) VALUES
(996839, 50, 0, 'Brannik takes careful aim. Break his line of sight!' , 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School encounter warning' );

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 996865;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 996865 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = -9996865 AND `source_type` = 0;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(-9996865, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8600, 9400, 0, 0, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Geomancer Grivik' ),
(-9996865, 0, 100, 0, 2, 0, 100, 1, 30, 60, 0, 0, 0, 0, 80, 99686558, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `smart_scripts` WHERE `entryorguid` = 99686558 AND `source_type` = 9;
INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`,
    `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `event_param5`, `event_param6`, `action_type`, `action_param1`,
    `action_param2`, `action_param3`, `action_param4`, `action_param5`,
    `action_param6`, `target_type`, `target_param1`, `target_param2`,
    `target_param3`, `target_param4`, `target_x`, `target_y`,
    `target_z`, `target_o`, `comment`) VALUES
(99686558, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' ),
(99686558, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 11990, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
    'Old School announced encounter moment' );

DELETE FROM `creature_text` WHERE `CreatureID` = 996865 AND `GroupID` = 50;
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
`BroadcastTextId`, `TextRange`, `comment`) VALUES
(996865, 50, 0, 'Grivik gathers burning embers. Move away from the rain of fire!' , 16, 0, 100, 0, 0, 0, 0, 0,
    'Old School encounter warning' );
