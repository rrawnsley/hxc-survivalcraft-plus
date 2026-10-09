-- HXC fallback for CoA Custom 1.4 Vulpera display bounds; the repack-only source IDs are absent in HXC world data.
START TRANSACTION;
DELETE FROM `creature_model_info` WHERE `DisplayID` IN (977493,977494);
INSERT INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`Gender`,`DisplayID_Other_Gender`) SELECT 977493,`BoundingRadius`,`CombatReach`,0,0 FROM `creature_model_info` WHERE `DisplayID`=55;
DELETE FROM `creature_model_info` WHERE `DisplayID`=977494;
INSERT INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`Gender`,`DisplayID_Other_Gender`) SELECT 977494,`BoundingRadius`,`CombatReach`,1,0 FROM `creature_model_info` WHERE `DisplayID`=56;
COMMIT;
