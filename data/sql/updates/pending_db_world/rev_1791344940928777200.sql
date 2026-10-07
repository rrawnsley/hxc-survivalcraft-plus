DELETE FROM `spell_bonus_data` WHERE `entry` IN (500126, 504014);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(500126, 0, 0, 0.2, 0, 'CoA - Lunge: native tooltip 20% attack power'),
(504014, 0, 0, 0.342, 0, 'CoA - Soulslam: native tooltip 34.2% attack power');
