INSERT INTO `item_template`
(`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`,
 `ItemLevel`, `RequiredLevel`, `stackable`, `description`, `ScriptName`, `spellid_1`, `spelltrigger_1`,
 `spellcharges_1`, `spellcategory_1`, `spellcategorycooldown_1`)
VALUES
(996215, 0, 8, -1, 'Field Splint', 8936, 1, 0,
 1, 1, 20, CONCAT('Crafted with Survivalist from 4 Simple Wood and 2 Linen Cloth. ',
 'Use outside combat to treat one broken leg or arm. Consumed on success.'),
 'item_coa_survival_tool', 996119, 0, 0, 0, 0)
ON DUPLICATE KEY UPDATE `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
 `name` = VALUES(`name`), `displayid` = VALUES(`displayid`), `stackable` = VALUES(`stackable`),
 `description` = VALUES(`description`), `ScriptName` = VALUES(`ScriptName`),
 `spellid_1` = VALUES(`spellid_1`), `spelltrigger_1` = VALUES(`spelltrigger_1`);
UPDATE `item_template` SET `Material` = -1 WHERE `entry` = 996215;
