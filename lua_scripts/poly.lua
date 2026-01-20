local POLYMORPH_AURA_ID = 118 
local sheep_health_registry = {} -- Store HP values indexed by GUID

print(">> Souls-like: Polymorph Health-Freeze Script Loaded")

-- Function to enforce the health freeze
local function EnforceHealthFreeze(player, targetGUID)
    local map = player:GetMap()
    if not map then return end
    
    local unit = map:GetWorldObject(targetGUID)
    if unit and unit:ToUnit() then
        unit = unit:ToUnit()
        
        -- Check if they still have the Polymorph Aura
        if unit:HasAura(POLYMORPH_AURA_ID) then
            local currentHP = unit:GetHealth()
            local storedHP = sheep_health_registry[targetGUID] or currentHP
            
            if currentHP > storedHP then
                -- Natural regen tried to heal them! Force it back.
                unit:SetHealth(storedHP)
            elseif currentHP < storedHP then
                -- Unit was damaged by a player! Update the floor.
                sheep_health_registry[targetGUID] = currentHP
            end
        else
            -- Aura is gone, stop watching this unit
            sheep_health_registry[targetGUID] = nil
        end
    else
        sheep_health_registry[targetGUID] = nil
    end
end

-- Hook into Spell Casts
local function OnSpellFinished(event, player, spell)
    if spell:GetEntry() == POLYMORPH_AURA_ID then
        local target = spell:GetTarget()
        if target then
            local guid = target:GetGUID()
            local initialHP = target:GetHealth()
            
            sheep_health_registry[guid] = initialHP
            print("FREEZE: Target " .. target:GetName() .. " health locked at " .. initialHP)

            -- Check and enforce health every 250ms for the duration of the sheep
            -- This creates a repeating event that cleans itself up
            player:RegisterEvent(function(eventId, delay, calls, p)
                if sheep_health_registry[guid] then
                    EnforceHealthFreeze(p, guid)
                else
                    p:RemoveEventById(eventId) -- Stop the timer if registry is empty
                end
            end, 250, 0) -- 0 means repeat forever until manually stopped
        end
    end
end

RegisterPlayerEvent(5, OnSpellFinished)