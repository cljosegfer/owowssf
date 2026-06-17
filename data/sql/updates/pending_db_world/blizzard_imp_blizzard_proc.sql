-- Improved Blizzard (spell_proc -11185): add PROC_FLAG_DONE_PERIODIC (0x40000) so the
-- talent's chill procs off DynamicObject periodic damage ticks.
-- Background: removing SPELL_ATTR1_IS_CHANNELED from Blizzard means damage now comes from
-- the SPELL_AURA_PERIODIC_DAMAGE aura on the DynObj (Effect[0]) rather than the inner
-- trigger spell (Effect[1], which required m_channelData to know the target destination).
-- Periodic damage fires PROC_FLAG_DONE_PERIODIC, not PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG.
UPDATE `spell_proc`
SET `ProcFlags` = `ProcFlags` | 0x00040000
WHERE `SpellId` = -11185;
