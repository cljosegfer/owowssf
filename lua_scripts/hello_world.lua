-- Print to the Server Console (Docker Log)
print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
print("!!! ELUNA LUA ENGINE HAS LOADED SUCCESSFULLY !!!")
print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

-- In-Game Message
local function OnLogin(event, player)
    player:SendBroadcastMessage("|cff00ccff[Eluna]|r System Online. Welcome, " .. player:GetName())
end

-- 2. Create a Custom Command to test Eluna In-Game
local function OnCommand(event, player, command)
    if command == "test" then
        player:SendBroadcastMessage("Eluna is listening.")
        return false -- Stop the server from saying "Unknown command"
    end
end

RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(42, OnCommand)  -- EVENT_ON_COMMAND