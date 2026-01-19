-- ============================================================
-- SOULS-LIKE POTIONS (v5: Robust Intent)
-- ============================================================

local POTION_DATA = {
    -- [Item ID] = Spell ID to Reset
    [118] = 439,   -- Minor Healing Potion -> Healing
    [2455] = 437,  -- Minor Mana Potion -> Restore Mana
    [858] = 440,   -- Lesser Healing Potion
    [3385] = 438,  -- Lesser Mana Potion -> Restore Mana
}

-- Short delay to ensure we wipe the CD *after* the server applies it.
-- 250ms is safe.
local ESTUS_DELAY_MS = 1000 -- slightly less than GCD for robustness

local function Log(msg)
    print("[PotionRobust] " .. msg)
end

local function OnItemUse(event, player, item, target)
    local itemId = item:GetEntry()
    
    -- 1. Check if this is an Estus Flask
    local spellIdToReset = POTION_DATA[itemId]
    
    if spellIdToReset then
        -- 2. Movement Check (Souls-like)
        if player:IsMoving() then
            player:SendNotification("Stop moving to drink!")
            return false -- Block
        end

        Log("Estus usage detected (" .. tostring(itemId) .. "). Scheduling cleanup...")

        -- 3. Schedule the Cooldown Wipe
        -- We do this REGARDLESS of whether the cast succeeds or fails.
        -- This acts as a "Desync Fixer" every time you press the button.
        player:RegisterEvent(function(eid, delay, repeats, p)
            if not p then return end
            
            -- A. Wipe Specific Spell CD
            p:ResetSpellCooldown(spellIdToReset, true)

            -- B. Wipe Category CD (Combat Lock)
            if p.ResetTypeCooldowns then
                p:ResetTypeCooldowns(4) -- 4 = Potions
            elseif p.ResetSpellCategoryCooldown then
                p:ResetSpellCategoryCooldown(4)
            end
            
            Log("-> Cleanup executed. Potion should be ready (subject to 1.5s Item CD).")
            
        end, ESTUS_DELAY_MS, 1)
    end
    
    return true -- Allow the attempt
end

-- We no longer need OnSpellCast for this logic!
for itemId, _ in pairs(POTION_DATA) do
    RegisterItemEvent(itemId, 2, OnItemUse) 
end

print(">> Souls-Like Potions v5 (Robust Intent) Loaded")