-- Keep the level-60 Chronomancer rank available at its class trainer when
-- proficiency-based rank learning is disabled. The preceding rank is 567543.
DELETE FROM `trainer_spell` WHERE `TrainerId` = 900022 AND `SpellId` = 567544;
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`)
VALUES (900022, 567544, 23400, 0, 0, 567543, 0, 0, 60);
