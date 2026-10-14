INSERT INTO `item_template`
(`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`,
 `ItemLevel`, `RequiredLevel`, `InventoryType`, `stackable`, `description`, `ScriptName`, `spellid_1`, `spelltrigger_1`,
 `spellcharges_1`, `spellcategory_1`, `spellcategorycooldown_1`)
VALUES
(996214, 4, 0, -1, 'Survivalist Torch', 9323, 1, 0, 1, 1, 23, 1,
 'Crafted with Survivalist. Equip in your off hand, then use to light or extinguish. Improves outdoor night visibility.',
 'item_coa_survival_tool', 996181, 0, 0, 0, 0)
ON DUPLICATE KEY UPDATE `class` = VALUES(`class`), `subclass` = VALUES(`subclass`),
 `name` = VALUES(`name`), `displayid` = VALUES(`displayid`), `InventoryType` = VALUES(`InventoryType`),
 `description` = VALUES(`description`), `ScriptName` = VALUES(`ScriptName`), `spellid_1` = VALUES(`spellid_1`);
UPDATE `item_template` SET `Material` = 2 WHERE `entry` = 996214;
