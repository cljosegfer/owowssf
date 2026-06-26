-- Cast Remove Curse on self as a triggered spell, bypassing the client-side
-- "Nothing to dispel" check that would otherwise block magic/poison/disease targets.
-- Server-side OnLoadSpellCustomAttr already patches spell 475 to dispel all types.
--
-- Usage: create a WoW macro with "/say !rc" and bind it to a key.
RegisterPlayerEvent(18, function(event, player, msg, type, lang)
    if msg == "@rc" then
        player:CastSpell(player, 475, true) -- triggered = skips all pre-checks
        return false -- suppress the chat message
    end
end)

print(">> Remove Curse override loaded.")
