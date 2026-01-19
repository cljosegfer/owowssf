-- local POTION_ID = 858 -- Replace with your actual potion ID if different

-- -- This function runs 100ms AFTER the spell is cast
-- local function RemovePotionCooldownDelayed(eventId, delay, repeats, playerGuid)
--     local player = GetPlayerByGUID(playerGuid)
--     if player then
--         -- Remove the specific spell cooldown
--         player:RemoveSpellCooldown(POTION_ID, true)
        
--         -- OPTIONAL: If your core links potions to a Category (Shared CD), 
--         -- you might need to ensure the Category is cleared. 
--         -- However, usually removing the Spell ID is sufficient in AC.
        
--         -- Send a message to console to confirm it ran
--         print("[Lua] Delayed Cooldown Removal Executed for " .. player:GetName())
--     end
-- end

-- local function OnPlayerSpellCast(event, player, spell, skipCheck)
--     if spell:GetEntry() == POTION_ID then
--         print("[Lua] Potion Cast Detected. Scheduling removal in 100ms...")
        
--         -- Register a timed event on the player:
--         -- Function, Delay (ms), Repeats (1 = once), Arguments (playerGuid)
--         player:RegisterEvent(RemovePotionCooldownDelayed, 100, 1, player:GetGUID())
--     end
-- end

-- -- Register the event (Event 5 is PLAYER_EVENT_ON_SPELL_CAST)
-- RegisterPlayerEvent(5, OnPlayerSpellCast)