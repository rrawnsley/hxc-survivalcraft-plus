-- Base Hardcore starts from activation, so early level or loot history must
-- not prevent opt-in. Its death and gameplay rules are enforced from then on.
UPDATE coa_challenge_definition
SET conditions = ''
WHERE id = 54 AND name = 'Hardcore';
