DELETE FROM `gameobject` WHERE `id` = 996300;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`)
SELECT 996300, `type`, 627, 'Durotar Deadwood', `IconName`, 'Harvest Timber', `unk1`, 1, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`
FROM `gameobject_template` WHERE `entry` = 244628
ON DUPLICATE KEY UPDATE `type` = VALUES(`type`), `displayId` = VALUES(`displayId`),
`name` = VALUES(`name`), `Data0` = VALUES(`Data0`), `Data1` = VALUES(`Data1`);

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9002000 AND 9002023;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(9002000, 996300, 1, 14, 0, 1, 1073741824, -731.932, -4270.77, 42.2732, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002001, 996300, 1, 14, 0, 1, 1073741824, -462, -4200, 52.495, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002002, 996300, 1, 14, 0, 1, 1073741824, -723.068, -4169.88, 30.1956, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002003, 996300, 1, 14, 0, 1, 1073741824, -494.774, -4337.04, 38.654, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002004, 996300, 1, 14, 0, 1, 1073741824, -588.684, -4387.13, 43.235, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002005, 996300, 1, 14, 0, 1, 1073741824, -675.722, -4350.36, 44.603, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002006, 996300, 1, 14, 0, 1, 1073741824, -549.241, -4421.25, 42.1042, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002007, 996300, 1, 14, 0, 1, 1073741824, -485.464, -4381.5, 48.2731, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002008, 996300, 1, 14, 0, 1, 1073741824, -398, -4230, 56.047, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002009, 996300, 1, 14, 0, 1, 1073741824, -304.944, -4437.49, 59.18, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002010, 996300, 1, 14, 0, 1, 1073741824, -716.996, -4150.75, 30.0694, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002011, 996300, 1, 14, 0, 1, 1073741824, -354.141, -4421.33, 50.6012, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002012, 996300, 1, 14, 0, 1, 1073741824, -680.926, -4284.82, 39.9806, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002013, 996300, 1, 14, 0, 1, 1073741824, -447.311, -4355.99, 46.1737, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Valley of Trials deadwood'),
(9002014, 996300, 1, 14, 0, 1, 1073741824, -1047.05, -5383.41, 8.13052, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Senjin coastal deadwood'),
(9002015, 996300, 1, 14, 0, 1, 1073741824, -1186.91, -5380.54, 8.47154, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Senjin coastal deadwood'),
(9002016, 996300, 1, 14, 0, 1, 1073741824, -1012.25, -5144.59, 2.50305, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Senjin coastal deadwood'),
(9002017, 996300, 1, 14, 0, 1, 1073741824, -630.041, -4896.66, 30.3682, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar foothills deadwood'),
(9002018, 996300, 1, 14, 0, 1, 1073741824, 205.012, -5060.46, 13.7435, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar coast deadwood'),
(9002019, 996300, 1, 14, 0, 1, 1073741824, 401.143, -4861.65, 17.0926, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar foothills deadwood'),
(9002020, 996300, 1, 14, 0, 1, 1073741824, -648.15, -4768.83, 28.2864, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar foothills deadwood'),
(9002021, 996300, 1, 14, 0, 1, 1073741824, 20.9083, -4808.78, 23.6258, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar foothills deadwood'),
(9002022, 996300, 1, 14, 0, 1, 1073741824, 597.528, -4864.34, 24.7242, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar foothills deadwood'),
(9002023, 996300, 1, 14, 0, 1, 1073741824, -1037.11, -4779.67, 15.3859, 0, 0, 0, 0, 1, 180, 100, 1, '', 0, 'Old School - Durotar coast deadwood');
