-- Removes the cast bar from all mount spells.
-- Intercepts CMSG_CAST_SPELL, blocks the original packet, and re-casts as triggered (instant).
-- Detection uses SpellInfo:HasAura(78) — SPELL_AURA_MOUNTED — so no hardcoded ID list is needed.

local CMSG_CAST_SPELL    = 302
local SPELL_AURA_MOUNTED = 78

-- Cached per spell ID so SpellInfo is only queried once per unique spell.
local mountCache = {}

local function IsMountSpell(spellId)
    if mountCache[spellId] ~= nil then
        return mountCache[spellId]
    end
    local info   = GetSpellInfo(spellId)
    local result = (info ~= nil) and info:HasAura(SPELL_AURA_MOUNTED)
    mountCache[spellId] = result
    return result
end

local function OnCastPacket(event, packet, player)
    local count   = packet:ReadUByte()
    local spellId = packet:ReadULong()

    if not IsMountSpell(spellId) then return true end
    if player:IsMounted() then return false end
    if not player:HasSpell(spellId) then return false end

    player:CastSpell(player, spellId, true)
    return false
end

RegisterPacketEvent(CMSG_CAST_SPELL, 5, OnCastPacket)
print(">> Instant Mounts loaded.")
