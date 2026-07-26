-- Removes the 20-hour cooldown on Inscription profession research.
-- Both spells are instant effects (no channel), so a single cooldown
-- reset shortly after cast is enough - see evocation_no_cd.lua for the
-- channeled-spell variant of this same pattern.
local NO_CD_SPELLS = {
    [61288] = true, -- Minor Inscription Research
    [61177] = true, -- Northrend Inscription Research
}

RegisterPlayerEvent(5, function(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if not NO_CD_SPELLS[spellId] then return end

    local guid = player:GetGUID()
    CreateLuaEvent(function(eventId)
        local p = GetPlayerByGUID(guid)
        if p then
            p:ResetSpellCooldown(spellId, true)
        end
        RemoveEventById(eventId)
    end, 200, 1)
end)

print(">> Inscription research no-cooldown loaded.")
