require '/ComputerCraftThings/library'

--TODO: Write pocket computer program to check on reactor stuff


function getTurbines()
    --Returns a count of the turbines and a table of their names
    local turbines = {}
    
    for turbineIndex = 1,100 do --TODO: Maybe change to while loop idk
        --turbineIndex is the int value of the current check, starting at 1
        --turbineStr is the string for the peripheral name
        local turbineStr = 'BigReactors-Turbine_'..turbineIndex
        --print('DEBUG: Checking '..turbineIndex..' named '..turbineStr) --DEBUG
        if peripheral.isPresent(turbineStr) then
            --print('DEBUG: '..turbineStr..' was found. Adding to index..') --DEBUG
            table.insert(turbines, turbineStr)
        end
        -- else
        --     --print('No more turbines found. Exiting at '..turbineIndex) --DEBUG
        --     --Once a turbine is not found, set the turbineCount and break the loop
        --     turbineCount = turbineIndex-1
        --     break
        -- end
    end

    local turbineCount = tableLength(turbines)
    return turbineCount, turbines
end

function debugTurbines()
    local turbineCount,turbines = getTurbines()
    for i=1,turbineCount do
        local turbineStr = turbines[i]
        local turbine = peripheral.wrap(turbineStr)
        print('Turbine Name: '..turbineStr)
        print('Turbine Active: '..tostring(turbine.getActive()))
        print('Turbine RPM: '..turbine.getRotorSpeed())
        print('Turbine Input Amount: '..turbine.getInputAmount())
        print('Turbine Energy Stored: '..turbine.getEnergyStored())
    end
end

--DEBUG
turbineCount,turbines = getTurbines()

term.clear()
print('Turbine Debug Info:')

print('DEBUG: turbine count: '..tostring(turbineCount))
print('DEBUG: turbines: '..table.concat(turbines, ", "))
--print(tostring(turbines[1]))
debugTurbines()