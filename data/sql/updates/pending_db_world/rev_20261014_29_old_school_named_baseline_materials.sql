DELETE FROM `creature_loot_template`
WHERE `Entry` BETWEEN 996701 AND 996779 AND `Item` IN (785, 2318, 2319, 2589, 2592, 2770, 2771, 2772, 3355, 3357, 3858,
    4234, 4304, 4306, 4338, 8170, 8838, 10620, 13464, 14047);
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`)
SELECT `entry`,
CASE
    WHEN `name` LIKE '%bark%' OR `name` LIKE '%heart%' OR `name` LIKE '%gnarl%' THEN CASE
        WHEN `minlevel` < 15 THEN 785
        WHEN `minlevel` < 25 THEN 3355
        WHEN `minlevel` < 40 THEN 3357
        WHEN `minlevel` < 50 THEN 8838
        ELSE 13464 END
    WHEN `type` IN (1, 2) THEN CASE
        WHEN `minlevel` < 20 THEN 2318
        WHEN `minlevel` < 30 THEN 2319
        WHEN `minlevel` < 40 THEN 4234
        WHEN `minlevel` < 50 THEN 4304
        ELSE 8170 END
    WHEN `type` IN (4, 9) THEN CASE
        WHEN `minlevel` < 20 THEN 2770
        WHEN `minlevel` < 30 THEN 2771
        WHEN `minlevel` < 40 THEN 2772
        WHEN `minlevel` < 50 THEN 3858
        ELSE 10620 END
    ELSE CASE
        WHEN `minlevel` < 15 THEN 2589
        WHEN `minlevel` < 25 THEN 2592
        WHEN `minlevel` < 40 THEN 4306
        WHEN `minlevel` < 50 THEN 4338
        ELSE 14047 END
END, 0, 100, 0, 1, 0, 1, 2
FROM `creature_template` WHERE `entry` BETWEEN 996701 AND 996779;
