-- Temporary diagnostic: logs every SMSG_CAST_FAILED sent to a player, along
-- with their current map/zone/area, so we can see exactly which spell was
-- rejected, with which SpellCastResult code, and where.
-- Remove this file once the flying-mount issue is diagnosed.

local SMSG_CAST_FAILED = 0x130

local function OnCastFailed(event, packet, player)
    local castCount = packet:ReadUByte()
    local spellId   = packet:ReadULong()
    local result    = packet:ReadUByte()

    local msg = string.format(
        "[CastFailed] player=%s spell=%d result=%d map=%d zone=%d area=%d",
        player:GetName(), spellId, result,
        player:GetMapId(), player:GetZoneId(), player:GetAreaId())

    print(msg)
    player:SendBroadcastMessage("|cffff0000[Debug]|r " .. msg)

    return true -- observe only, don't block the packet
end

RegisterPacketEvent(SMSG_CAST_FAILED, 7, OnCastFailed) -- PACKET_EVENT_ON_PACKET_SEND
print(">> Cast Failure Debug loaded.")
