local EVOCATION = 12051

-- Evocation has SPELL_ATTR0_COOLDOWN_ON_EVENT: the client receives SMSG_COOLDOWN_EVENT
-- when the channel ends and applies the 8-min DBC cooldown locally. The server-side
-- cooldown is already 0 via spell_cooldown_overrides. We poll after cast start to
-- send SMSG_CLEAR_COOLDOWN once the client cooldown appears.
RegisterPlayerEvent(5, function(event, player, spell, skipCheck)
    if spell:GetEntry() ~= EVOCATION then return end

    local guid = player:GetGUID()
    local rep = 0

    CreateLuaEvent(function(eventId)
        rep = rep + 1
        local p = GetPlayerByGUID(guid)
        if not p then
            RemoveEventById(eventId)
            return
        end
        p:ResetSpellCooldown(EVOCATION, true)
        if rep >= 50 then
            RemoveEventById(eventId)
        end
    end, 200, 50) -- every 200ms for 10 seconds (covers full channel + early cancel)
end)

print(">> evocation loaded.")
