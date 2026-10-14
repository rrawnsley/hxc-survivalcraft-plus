DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996887;
INSERT INTO `creature_equip_template`
    (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT 996887, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 28608;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996888;
INSERT INTO `creature_equip_template`
    (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT 996888, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 28530;

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 996889;
INSERT INTO `creature_equip_template`
    (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`)
SELECT 996889, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`
FROM `creature_equip_template` WHERE `CreatureID` = 29080;
