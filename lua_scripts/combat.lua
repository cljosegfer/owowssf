-- ============================================================
-- SOULS-LIKE COMBAT: FINAL PRODUCTION VERSION
-- ============================================================

-- 1. SPELL CONFIGURATION (TUNE THIS!)
-- [SpellID] = { cd = Seconds, mana = ManaCost }
-- cd is double cast time and mana is flat from earliest lvl
local SPELL_DATA = {
    -- MAGE
    [133] = { cd = 3.0, mana = 13 },  -- Fireball Rank 1
    [116] = { cd = 3.0, mana = 16 },  -- Frostbolt Rank 1
    
    -- Add new spells here as you learn them (Check WoWHead for IDs)
    [143] = { cd = 4.0, mana = 35 },  -- Fireball Rank 2
}

-- 2. GLOBAL COOLDOWN (The "Weight" of combat)
-- Set this higher (1.5 or 2.0) to make combat feel heavy/slow.
-- Set this lower (0.5 or 1.0) to make it feel snappy.
local USE_GCD = true
local GCD_SEC = 1.5

-- 3. CONSTANTS (Do not change)
local CMSG_CAST_SPELL = 302 
local FIELD_MANA = 25 -- The Magic Number you found!

-- ============================================================
-- LOGIC
-- ============================================================
local cooldowns = {} -- [PlayerGUID][SpellID]
local gcds = {}      -- [PlayerGUID]

local function OnCastPacket(event, packet, player)
    -- Read packet header
    local count = packet:ReadUByte()
    local spellId = packet:ReadULong()

    -- Is this a configured spell?
    local config = SPELL_DATA[spellId]
    if not config then return true end -- Let normal game handle non-configured spells

    -- Basic Checks
    if not player:HasSpell(spellId) then return false end
    
    local target = player:GetSelection()
    if not target then
        player:SendNotification("No Target")
        return false 
    end

    -- ========================================================
    -- COOLDOWN CHECKS (Here is the logic you were looking for)
    -- ========================================================
    local guid = player:GetGUIDLow()
    local now = os.time() 

    -- A. Global Cooldown Check
    if USE_GCD and gcds[guid] and gcds[guid] > now then
        -- Silent fail (prevents spamming chat with errors)
        return false 
    end

    -- B. Specific Spell Cooldown Check
    if not cooldowns[guid] then cooldowns[guid] = {} end
    if cooldowns[guid][spellId] and cooldowns[guid][spellId] > now then
        local remaining = cooldowns[guid][spellId] - now
        player:SendNotification("Not Ready (" .. remaining .. "s)")
        return false
    end

    -- ========================================================
    -- MANA CHECK & DEDUCTION
    -- ========================================================
    local currentMana = player:GetInt32Value(FIELD_MANA)
    
    if currentMana < config.mana then
        player:SendNotification("Not enough Mana!")
        return false
    end

    -- Deduct Mana immediately (The Hack)
    player:SetInt32Value(FIELD_MANA, currentMana - config.mana)

    -- ========================================================
    -- APPLY COOLDOWNS (The Cost)
    -- ========================================================
    
    -- Set when this specific spell can be used again
    cooldowns[guid][spellId] = now + config.cd
    
    -- Set when ANY spell can be used again
    if USE_GCD then
        gcds[guid] = now + GCD_SEC
    end

    -- ========================================================
    -- ACTION (The Reward)
    -- ========================================================
    
    -- Cast Instant (Triggered=true ignores standard checks)
    player:CastSpell(target, spellId, true)

    -- Block the original packet so the client doesn't start the slow cast bar
    return false 
end

RegisterPacketEvent(CMSG_CAST_SPELL, 5, OnCastPacket)
print(">> Souls-Like Combat: FINAL loaded.")