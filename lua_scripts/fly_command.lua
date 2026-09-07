-- ".fly [spellId]" casts a known flying mount server-side.
--
-- The 3.3.5a client checks its own local AreaTable.dbc before letting the
-- mount button send CMSG_CAST_SPELL at all, so outside Outland/Northrend it
-- never contacts the server ("You can't use that here" is generated purely
-- client-side). This command sidesteps that by casting the mount directly
-- via Player:CastSpell, which still runs full server-side validation
-- (SpellInfo::CheckLocation) -- so it relies on the Azeroth flying-mount
-- restriction already being lifted there.

local SPELL_AURA_MOUNTED                           = 78
local SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED = 207

local flyingMountCache = {}

local function IsFlyingMountSpell(spellId)
    if flyingMountCache[spellId] ~= nil then
        return flyingMountCache[spellId]
    end
    local info   = GetSpellInfo(spellId)
    local result = (info ~= nil)
        and info:HasAura(SPELL_AURA_MOUNTED)
        and info:HasAura(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED)
    flyingMountCache[spellId] = result
    return result
end

local function FindKnownFlyingMount(player)
    for _, spellId in pairs(player:GetSpells()) do
        if IsFlyingMountSpell(spellId) then
            return spellId
        end
    end
    return nil
end

local function OnCommand(event, player, command, chatHandler)
    if not player then return true end

    local args = {}
    for word in command:gmatch("%S+") do
        args[#args + 1] = word
    end
    if args[1] ~= "fly" then return true end

    local spellId = tonumber(args[2])
    if spellId then
        if not player:HasSpell(spellId) or not IsFlyingMountSpell(spellId) then
            player:SendBroadcastMessage("|cffff0000[Fly]|r You don't know a flying mount with spell id " .. spellId .. ".")
            return false
        end
    else
        spellId = FindKnownFlyingMount(player)
        if not spellId then
            player:SendBroadcastMessage("|cffff0000[Fly]|r You don't know any flying mounts.")
            return false
        end
    end

    if player:IsMounted() then
        player:Dismount()
    end

    player:CastSpell(player, spellId, true)
    return false
end

RegisterPlayerEvent(42, OnCommand) -- PLAYER_EVENT_ON_COMMAND
print(">> .fly command loaded.")
