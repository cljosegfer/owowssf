local function OnLogin(event, player)
    print("========================================")
    print("DEBUG: MANA & POWER PROBE")
    print("========================================")

    -- 1. Check Global Constants
    print("Global POWER_MANA: " .. tostring(POWER_MANA))
    print("Global UNIT_FIELD_POWER1: " .. tostring(UNIT_FIELD_POWER1))
    
    -- 2. Check Player Info
    local pType = player:GetPowerType()
    print("Player Power Type ID: " .. tostring(pType))
    print("Current Mana (GetPower): " .. player:GetPower(pType))

    -- 3. Test ModifyPower Protected Call (To see if it works with variable)
    local status, err = pcall(player.ModifyPower, player, pType, -1)
    print("Test ModifyPower(pType): " .. tostring(status))
    if not status then print("Error: " .. tostring(err)) end

    -- 4. Test SetPower
    status, err = pcall(player.SetPower, player, pType, 500)
    print("Test SetPower(pType): " .. tostring(status))
    
    -- 5. Test Raw Memory Access (The Hacker Method)
    if UNIT_FIELD_POWER1 then
        local currentRaw = player:GetInt32Value(UNIT_FIELD_POWER1)
        print("Raw Memory Mana (UNIT_FIELD_POWER1): " .. currentRaw)
    else
        print("UNIT_FIELD_POWER1 is nil (Cannot use raw memory method)")
    end
    print("========================================")
end

RegisterPlayerEvent(3, OnLogin)