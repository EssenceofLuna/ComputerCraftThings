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
    --Function that prints out a bunch of debug info for all connected turbines
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

--TODO: Add functionality for booting multiple turbines at once
function startTurbine(turbineIndex)
    local turbineCount,turbines = getTurbines()
    turbineStr = turbines[turbineIndex]
    turbine = peripheral.wrap(turbineStr)
    print('Startup for turbine '..turbineIndex..' named '..turbineStr..' initiated.')
    --check if turbine is connected
    if turbine.getConnected() == false then
        print("Error: Turbine not connected. Aborting startup.")
        return
    end
    --If turbine is connected, continue

    --Check if turbine is powered on, and power on if not
    if turbine.getActive() == false then
        print('Turbine powering on...')
        turbine.setActive(true)
    end
    if turbine.getInductorEngaged() == true then
        print('Coils where engaged. Disengaging...')
        turbine.setInductorEngaged(false)
    end
    --TODO: Control flow rate of turbine

    --Loop to check rotor speed and engage coils when ready (at 1750 RPM)
    while true do
        local currentSpeed = turbine.getRotorSpeed()
        --print('DEBUG: Turbine Speed: '..currentSpeed) --Debug
        if currentSpeed >= 1800 then
            --Turbine as reached speed
            print('Turbine reached speed. Engaging coils.')
            turbine.setInductorEngaged(true)
            break
        else
            print('Turbine spinning up... '..currentSpeed..' RPM')
            sleep(10)
        end
    end
end

function startAllTurbines()
    --Starts all connected turbines
    local turbineCount,turbines = getTurbines()
    --TODO: Write this
    local startedTurbines = 0
    while true do
        for i=1,turbineCount do
            local turbineStr = turbines[i]
            local turbine = peripheral.wrap(turbineStr)
            local turbineSpeed = turbine.getRotorSpeed()

            --check if turbine is connected
            if turbine.getConnected() == false then
                print("Error: Turbine "..i.." not connected. Aborting startup.")
                return
            end
            --If turbine is connected, continue

            --Check if turbine is powered on, and power on if not
            if turbine.getActive() == false then
                print('Turbine '..i..' powering on...')
                turbine.setActive(true)
            end
            if turbine.getInductorEngaged() == true then
                print('Coils where engaged on turbine '..i..'. Disengaging...')
                turbine.setInductorEngaged(false)
            end
            --TODO: Control flow rate of turbine
            
            --DEBUG
            --print('Debug: Checked Turbine '..i..' and got '..turbineSpeed)
            if turbineSpeed >= 1800 then
                --Turbine as reached speed
                print('Turbine '..i..' reached speed. Engaging coils.')
                turbine.setInductorEngaged(true)
                table.remove(turbines, i)
                break
            else
                print('Debug: Turbine '..i..' not ready. '..turbineSpeed)
            end

            sleep(5) --TODO: Adjust sleep time depending on remaining turbines
        end
    end
end

--DEBUG
turbineCount,turbines = getTurbines()

term.clear()
print('Turbine Debug Info:')

print('DEBUG: turbine count: '..tostring(turbineCount))
print('DEBUG: turbines: '..table.concat(turbines, ", "))
--print(tostring(turbines[1]))
--debugTurbines()
startTurbine(1)
startTurbine(2)
startTurbine(3)