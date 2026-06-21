-- Arcane Explosion: register script that detonates around the selected target instead of the caster.
-- Using -1449 (negative = apply to all ranks in the spell rank chain).
DELETE FROM `spell_script_names` WHERE `spell_id` = -1449 AND `ScriptName` = 'spell_mage_arcane_explosion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-1449, 'spell_mage_arcane_explosion');
