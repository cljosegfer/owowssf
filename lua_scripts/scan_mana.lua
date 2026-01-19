local function OnCommand(event, player, command)
    if command == "scan" then
        print("========================================")
        print("DEBUG: MEMORY SCANNER")
        
        -- 1. Get the target value (Real Mana)
        -- We know GetPower(0) reads the correct value, even if we can't write to it.
        local realMana = player:GetPower(0) 
        print("Looking for value: " .. realMana)
        
        if realMana == 0 then
            player:SendBroadcastMessage("Mana is 0, cannot scan accurately. Drink a potion!")
            return false
        end

        -- 2. Scan indices 0 to 1000
        -- Unit fields usually start around 6, Power is usually around 24-80 depending on expansion
        local found = false
        for i = 0, 1000 do
            local val = player:GetInt32Value(i)
            if val == realMana then
                print(">>> MATCH FOUND AT INDEX: " .. i)
                player:SendBroadcastMessage("Found Mana at Index: " .. i)
                found = true
            end
        end
        
        if not found then
            print("No matching index found.")
        end
        print("========================================")
        return false
    end
end

RegisterPlayerEvent(42, OnCommand)