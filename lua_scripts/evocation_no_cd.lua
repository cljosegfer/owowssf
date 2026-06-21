-- Spells whose cooldowns should be removed.
--
-- channel = true  → cooldown fires at channel END via SMSG_COOLDOWN_EVENT
--                   (SPELL_ATTR0_COOLDOWN_ON_EVENT); poll until the channel finishes.
-- channel = false → cooldown fires immediately on cast; a single clear after 200ms suffices.
--
-- Requires a matching row in spell_cooldown_overrides (mage_no_cooldowns.sql) to also
-- zero out the server-side cooldown.
local NO_CD_SPELLS = {
    [12051] = { channel = true  },  -- Evocation
    [2139]  = { channel = false },  -- Counterspell
}

RegisterPlayerEvent(5, function(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    local cfg = NO_CD_SPELLS[spellId]
    if not cfg then return end

    local guid = player:GetGUID()
    local maxRep = cfg.channel and 50 or 1
    local rep = 0

    CreateLuaEvent(function(eventId)
        rep = rep + 1
        local p = GetPlayerByGUID(guid)
        if not p then
            RemoveEventById(eventId)
            return
        end
        p:ResetSpellCooldown(spellId, true)
        if rep >= maxRep then
            RemoveEventById(eventId)
        end
    end, 200, maxRep)
end)

print(">> mage no-cooldown spells loaded.")
