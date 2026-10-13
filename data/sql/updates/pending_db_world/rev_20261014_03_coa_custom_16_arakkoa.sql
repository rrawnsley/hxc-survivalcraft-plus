-- HXC SurvivalCraft+ CoA Custom 1.6: enable the Alliance Arakkoa race (race 79).
START TRANSACTION;

DELETE FROM `playercreateinfo` WHERE `race` = 79;
INSERT INTO `playercreateinfo`
SELECT 79, `class`, `map`, `zone`, `position_x`, `position_y`, `position_z`, `orientation`
FROM `playercreateinfo`
WHERE `race` = 1;

DELETE FROM `playercreateinfo_item` WHERE `race` = 79;
INSERT INTO `playercreateinfo_item`
SELECT 79, `class`, `itemid`, `amount`, `Note`
FROM `playercreateinfo_item`
WHERE `race` = 1;

DELETE FROM `playercreateinfo_action` WHERE `race` = 79;
INSERT INTO `playercreateinfo_action`
SELECT 79, `class`, `button`, `action`, `type`
FROM `playercreateinfo_action`
WHERE `race` = 1;

DELETE FROM `player_race_stats` WHERE `Race` = 79;
INSERT INTO `player_race_stats`
SELECT 79, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`
FROM `player_race_stats`
WHERE `Race` = 1;

DELETE FROM `ascension_custom_class_race` WHERE `race` = 79;
INSERT INTO `ascension_custom_class_race` (`class`, `race`)
SELECT DISTINCT `class`, 79 FROM `ascension_custom_class_race`;

DELETE FROM `creature_model_info` WHERE `DisplayID` = 977507;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`)
SELECT 977507, `BoundingRadius`, `CombatReach`, 0, 0 FROM `creature_model_info` WHERE `DisplayID` = 49;

DELETE FROM `creature_model_info` WHERE `DisplayID` = 977508;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`)
SELECT 977508, `BoundingRadius`, `CombatReach`, 1, 0 FROM `creature_model_info` WHERE `DisplayID` = 50;

COMMIT;
