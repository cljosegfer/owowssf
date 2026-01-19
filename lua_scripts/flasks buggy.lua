-- -- ============================================================
-- -- SOULS-LIKE POTIONS (v4: Combat Sync)
-- -- ============================================================

-- local POTION_DATA = {
--     [118] = 439,   -- Minor Healing Potion -> Healing
--     [2455] = 437,  -- Minor Mana Potion -> Restore Mana
--     [858] = 440,   -- Lesser Healing Potion -> Healing Potion
--     [3385] = 438,  -- Lesser Mana Potion -> Restore Mana
-- }

-- -- The "Estus Sip" time. 
-- -- The potion remains on cooldown for this duration before resetting.
-- local ESTUS_DELAY_MS = 1000 

-- -- 1. MOVEMENT CHECK (Stop to Drink)
-- local function OnItemUse(event, player, item, target)
--     if player:IsMoving() then
--         player:SendNotification("Stop moving to drink!")
--         return false -- Block the usage
--     end
--     return true 
-- end

-- local function Log(msg)
--     print("[PotionDebug] " .. msg)
-- end

-- -- 1. DETECT ITEM USE (Right Click)
-- local function OnItemUse(event, player, item, target)
--     local itemId = item:GetEntry()
--     Log("Step 1: Item Used ID: " .. tostring(itemId) .. " at time: " .. tostring(GetGameTime()))

--     if player:IsMoving() then
--         Log("-> FAIL: Player is moving. Blocking.")
--         player:SendNotification("Stop moving to drink!")
--         return false 
--     end
    
--     Log("-> SUCCESS: Player standing still. Allowing Item Use.")
--     return true 
-- end

-- -- 2. COOLDOWN CLEAR
-- local function OnSpellCast(event, player, spell, skipCheck)
--     local spellId = spell:GetEntry()
--     Log("Step 2 Check: Server is casting Spell ID: " .. tostring(spellId))
    
--     -- Check if this spell is triggered by one of our potions
--     local isPotionSpell = false
--     for _, potSpellId in pairs(POTION_DATA) do
--         if potSpellId == spellId then
--             Log("   -> MATCH! Spell " .. tostring(spellId) .. " matches Item " .. tostring(itemId))
--             isPotionSpell = true
--             break
--         end
--     end

    
--     if isPotionSpell then
--         Log("Step 2: Potion Spell Detected ID: " .. spellId)
--         local timerStart = GetGameTime()

--         -- We delay the reset by 1.5s (The GCD/Sip time).
--         -- This allows the client to sync and prevents instant spamming.
--         player:RegisterEvent(function(eid, delay, repeats, p)
--             local now = GetGameTime()
--             Log("Step 3: Timer Triggered after " .. tostring(now - timerStart) .. "ms")

--             if not p then
--                 Log("-> ERROR: Player not found (Logged out?)")
--                 return
--             end

--             if p:HasSpellCooldown(spellId) then
--                 Log("-> Found Cooldown on Spell " .. spellId .. ". Removing...")
--                 p:ResetSpellCooldown(spellId, true)
--             else
--                 Log("-> WARNING: No Cooldown found on Spell " .. spellId)
--             end
--             -- -- A. Reset this specific spell (The 10s cooldown)
--             -- p:ResetSpellCooldown(spellId, true)

--             -- B. Reset Category Cooldowns (The "Potion Sickness")
--             -- Category 4 is the standard Potion category.
--             Log("-> Resetting Category 4 Cooldowns...")
--             if p.ResetTypeCooldowns then
--                 p:ResetTypeCooldowns(4)
--             elseif p.ResetSpellCategoryCooldown then
--                  p:ResetSpellCategoryCooldown(4)
--             else
--                 Log("-> ERROR: No Reset Category function found!")
--             end
            
--             -- Optional: Visual cue
--             Log("Step 4: Reset Complete.")
--             p:SendNotification("Ready") 
--         end, ESTUS_DELAY_MS, 1)
--     end
-- end

-- -- Register Item Events
-- for itemId, _ in pairs(POTION_DATA) do
--     RegisterItemEvent(itemId, 2, OnItemUse) 
-- end

-- -- Register Spell Event
-- RegisterPlayerEvent(5, OnSpellCast)

-- print(">> Souls-Like Potions v4 (Combat Sync) Loaded")