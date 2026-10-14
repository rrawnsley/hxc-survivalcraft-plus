INSERT INTO `item_template`
(`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`,
 `ItemLevel`, `RequiredLevel`, `stackable`, `description`, `ScriptName`, `spellid_1`, `spelltrigger_1`,
 `spellcharges_1`, `spellcategory_1`, `spellcategorycooldown_1`)
VALUES
(996211, 0, 8, -1, 'Campfire Kit', 7842, 1, 0, 1, 1, 20,
 'Crafted with Survivalist. Use outdoors to place a campfire. Consumed when the camp is placed.',
 'item_coa_survival_tool', 996106, 0, 0, 0, 0),
(996212, 0, 8, -1, 'Shelter Kit', 7842, 1, 0, 1, 1, 20,
 'Crafted with Survivalist skill 75. Use outdoors to place a shelter. Consumed when the shelter is placed.',
 'item_coa_survival_tool', 996107, 0, 0, 0, 0),
(996213, 0, 8, -1, 'Hearthstead Kit', 7842, 1, 0, 1, 1, 20,
 'Crafted with Survivalist skill 150. Use outdoors to place a hearthstead. Consumed when the hearthstead is placed.',
 'item_coa_survival_tool', 996108, 0, 0, 0, 0)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`), `displayid` = VALUES(`displayid`),
 `description` = VALUES(`description`), `ScriptName` = VALUES(`ScriptName`), `spellid_1` = VALUES(`spellid_1`);
UPDATE `item_template` SET `Material` = -1 WHERE `entry` IN (996211, 996212, 996213);
