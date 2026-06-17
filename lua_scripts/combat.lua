-- -- ============================================================
-- -- SOULS-LIKE COMBAT
-- -- ============================================================

-- -- 1. SPELL CONFIGURATION (TUNE THIS!)
-- -- [SpellID] = { cd = Cooldown in ms, mana = ManaCost }
-- local SPELL_DATA = {
--     -- MAGE
--     [133]  = { cd = 2000, mana = 8   },  -- Fireball Rank 1
--     [116]  = { cd = 1000, mana = 7   },  -- Frostbolt Rank 1

--     [143]  = { cd = 2000, mana = 14  },  -- Fireball Rank 2
--     [205]  = { cd = 1000, mana = 10  },  -- Frostbolt Rank 2
--     -- [118] = { cd = 6000,  mana = 28  },  -- Polymorph Rank 1
--     -- [122] = { cd = 16000, mana = 32  },  -- Frostnova Rank 1

--     [145]  = { cd = 2000, mana = 30  },  -- Fireball Rank 3
--     [837]  = { cd = 1000, mana = 21  },  -- Frostbolt Rank 3
--     [2120] = { cd = 2000, mana = 103 },  -- Flamestrike Rank 1

--     [3140] = { cd = 2000, mana = 50  },  -- Fireball Rank 4
--     [7322] = { cd = 1000, mana = 36  },  -- Frostbolt Rank 4
-- }

-- -- 2. GLOBAL COOLDOWN (ms) — raise to make combat feel heavier
-- local USE_GCD = true
-- local GCD_MS  = 500

-- -- 3. CONSTANTS
-- local CMSG_CAST_SPELL = 302

-- -- ============================================================
-- -- LOGIC
-- -- ============================================================
-- local cooldowns = {}  -- [playerGUID][spellId] = expiry time (ms)
-- local gcds       = {}  -- [playerGUID]          = expiry time (ms)

-- local function OnCastPacket(event, packet, player)
--     local count   = packet:ReadUByte()
--     local spellId = packet:ReadULong()

--     local config = SPELL_DATA[spellId]
--     if not config then return true end  -- pass non-configured spells through

--     if not player:HasSpell(spellId) then return false end

--     local target = player:GetSelection()
--     if not target then
--         player:SendNotification("No Target")
--         return false
--     end

--     if not player:IsWithinLoS(target) then
--         player:SendNotification("Target not in line of sight")
--         return false
--     end

--     local guid = player:GetGUIDLow()
--     local now  = GetCurrTime()  -- milliseconds since server start

--     -- GCD check
--     if USE_GCD and gcds[guid] and gcds[guid] > now then
--         return false
--     end

--     -- Per-spell cooldown check
--     if not cooldowns[guid] then cooldowns[guid] = {} end
--     if cooldowns[guid][spellId] and cooldowns[guid][spellId] > now then
--         local remaining = math.ceil((cooldowns[guid][spellId] - now) / 1000)
--         player:SendNotification("Not Ready (" .. remaining .. "s)")
--         return false
--     end

--     -- Mana check
--     local currentMana = player:GetPower(0)
--     if currentMana < config.mana then
--         player:SendNotification("Not enough Mana!")
--         return false
--     end

--     -- Deduct mana
--     player:SetPower(0, currentMana - config.mana)

--     -- Apply cooldowns
--     cooldowns[guid][spellId] = now + config.cd
--     if USE_GCD then
--         gcds[guid] = now + GCD_MS
--     end

--     -- Cast instant (triggered=true skips cast bar, mana cost, and range/LoS checks;
--     -- we enforce mana and LoS above, range is not currently checked)
--     player:CastSpell(target, spellId, true)
--     print("[Combat] " .. player:GetName() .. " cast spell " .. spellId)

--     return false  -- block original slow-cast packet
-- end

-- RegisterPacketEvent(CMSG_CAST_SPELL, 5, OnCastPacket)
-- print(">> Souls-Like Combat: loaded.")
