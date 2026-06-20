-- Bypasses AllowableClass restrictions so any class can equip class-restricted
-- items (Paladin librams, Druid idols, etc.) via PLAYER_EVENT_ON_CAN_USE_ITEM.
--
-- The armor/weapon proficiency skill check (PlayerStorage.cpp:CanUseItem) is
-- removed in C++ so this hook is only needed for AllowableClass-gated items.
--
-- TARGET_NAME: restrict to one character name, or set "" for all players.

local TARGET_NAME = ""

RegisterPlayerEvent(31, function(event, player, itemEntry)
    if TARGET_NAME ~= "" and player:GetName() ~= TARGET_NAME then return end
    return 0  -- EQUIP_ERR_OK
end)

print(">> all_proficiencies loaded.")
