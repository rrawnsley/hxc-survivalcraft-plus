CREATE TABLE IF NOT EXISTS `coa_old_school_corpse_item` (
    `guid` INT UNSIGNED NOT NULL,
    `item_guid` INT UNSIGNED NOT NULL,
    `slot` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (`guid`, `item_guid`),
    KEY `idx_guid_slot` (`guid`, `slot`),
    UNIQUE KEY `uq_item_guid` (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
