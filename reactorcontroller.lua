require '/ComputerCraftThings/APIs/library'

--TODO: Write pocket computer program to check on reactor stuff

--TODO: Write function to edit settings
--TODO: Allow setting different speeds for different turbines
--SETTINGS--
avoidTurbineMeltdown = true --Auto avoids turbines from melting down
autoRegulateTurbineSpeed = true --Auto regulates a turbine's speed
turbineSpeedGoal = 1800 --Either 900 or 1800, depending on desired RPM. Only matters if autoRegulateTurbineSpeed is true
logToFile = true --Log interactions with turbines and reactors to a log file --TODO: Implement this.

--TODO: Implement Rednet support
--Wait for rednet command using coroutine while running main update thing
--User input function will need to be rewritten for this
allowRednetCommands = true --Allow use of rednet to send commands
modemSide = 'right' --What side the ender modem is on

--Global Variables--
turbinesPoweredDown = false --True when user powers down turbines
reactorPoweredDown = false --True when user powers down reactor --TODO: Write reactor controlling lol

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
--This function not currently in use
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
    --TODO: When a turbine is done, all turbine numbers shift down to fill in. Maybe get turbine number from the string rather than i?
    turbinesPoweredDown = false
    local turbineCount,turbines = getTurbines()
    while true do
        local turbineCount = tableLength(turbines) --Recount turbines
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

            --Startup Info Screen--
            term.clear()
            term.setCursorPos(1,1)
            centerText("[Turbine Startup]") --TODO: Center this
            term.setCursorPos(1, 2)
            term.write('Turbines Remaining: '..turbineCount)
            
            --DEBUG
            --print('Debug: Checked Turbine '..i..' and got '..turbineSpeed)
            if turbineSpeed >= 1790 then
                --Turbine as reached speed
                --print('Turbine '..i..' reached speed. Engaging coils.') --DEBUG
                turbine.setInductorEngaged(true)
                table.remove(turbines, i)
                break
            else
                --print('Debug: Turbine '..i..' not ready. '..turbineSpeed)
            end

            sleep(5) --TODO?: Adjust sleep time depending on remaining turbines
        end

        if turbineCount <= 0 then
            --Finish loop when all turbines are up
            break
        end
    end
    term.clear()
    centerText("Finished booting turbines.")
end




function enableAllTurbines()
    --print("Enabling all turbines.") --Debug
    turbinesPoweredDown = false
    local turbineCount,turbines = getTurbines()
    for i=1,turbineCount do
        turbineStr = turbines[i]
        turbine = peripheral.wrap(turbineStr)
        turbine.setActive(true)
        --print("Enabling Turbine "..i) --Debug
    end
    --print("All turbines enabled.") --Debug
end


function disableAllTurbines()
    --print("Disabling all turbines.") --Debug
    turbinesPoweredDown = true
    local turbineCount,turbines = getTurbines()
    for i=1,turbineCount do
        turbineStr = turbines[i]
        turbine = peripheral.wrap(turbineStr)
        turbine.setActive(false)
        --print("Disabled Turbine "..i) --Debug
    end
    --print("All turbines disabled.") --Debug
end



function engageAllTurbines()
    --print("Engaging all turbines...") --Debug
    local turbineCount,turbines = getTurbines()
    for i=1,turbineCount do
        turbineStr = turbines[i]
        turbine = peripheral.wrap(turbineStr)
        turbine.setInductorEngaged(true)
        --print("DEBUG: Engaged Turbine "..i) --Debug
    end
    --print("All turbines engaged.") --Debug
end



function disengageAllTurbines()
    --print("Disengaging all turbines...") --Debug
    local turbineCount,turbines = getTurbines()
    for i=1,turbineCount do
        turbineStr = turbines[i]
        turbine = peripheral.wrap(turbineStr)
        turbine.setInductorEngaged(false)
        --print("DEBUG: Disengaged Turbine "..i) --Debug
    end
    --print("All turbines disengaged.") --Debug
end



function getUserCommand()
    local turbineCount,turbines = getTurbines()
    term.clear()
    while true do
        local turbineSpeeds = {}
        for i=1,turbineCount do
            --Put current turbine speeds into table turbineSpeeds which correspond with their locations in turbines
            local turbineStr = turbines[i]
            local turbine = peripheral.wrap(turbineStr)
            local speed = math.floor(turbine.getRotorSpeed())
            table.insert(turbineSpeeds, i, speed)
        end

        --term.clear()
        --TODO: Add functionality to  start/stop specific turbine. To do this, index all the turbines and list then to let the user pick one

        --TODO: Convert these term.write and term.setCursorPos to setWrite
        
        --term.setCursorPos(1,1)
        --centerText("Select a command")
        setWrite("Select a command",1,1)
        --term.setCursorPos(1,2)
        --term.write("0) Exit Program")
        setWrite("0( Exit Program",1,2)
        --term.setCursorPos(1,3)
        --term.write("1) Activate All Turbines")
        setWrite("1) Activate All Turbines",1,3)
        --term.setCursorPos(1,4)
        --term.write("2) Deactivate All Turbines")
        setWrite("2) Deactivate All Turbines",1,4)
        --term.setCursorPos(1,5)
        --term.write("3) Engage All Turbines")
        setWrite("3) Engage All Turbines",1,5)
        --term.setCursorPos(1,6)
        --term.write("4) Disengage All Turbines")
        setWrite("4) Disengage All Turbines",1,6)

        --term.setCursorPos(1,8)
        --term.write("Turbines:")
        setWrite("Turbines:",1,8)
        
        --TODO: Add support for reactor info (active and passive)

        --Runs once for each connected turbine
        for i=1,turbineCount do
            local turbineStr = turbines[i]
            local turbine = peripheral.wrap(turbineStr)
            local speed = math.floor(turbine.getRotorSpeed())
            local flowRate = turbine.getFluidFlowRate()
            local energyProduced = math.floor(turbine.getEnergyProducedLastTick()) --This turbine function returns a float, so math.floor is used to round it
            if turbine.getActive() then activeText = 'Active' else activeText = 'Inactive' end
            if turbine.getInductorEngaged() then engagedText = 'Engaged' else engagedText = 'Disengaged' end

            --Set to the line, clear it, then write new info in
            term.setCursorPos(1,8+i)
            term.clearLine()
            term.write(i..' '..engagedText..', '..activeText..': '..speed..' RPM, '..flowRate..' mB/t, '..energyProduced..' FE/t')

            if speed > 2000 and turbine.getActive() and turbine.getInductorEngaged() == false then
                --Turbine at risk of melting down. Engaging coils
                turbine.setInductorEngaged(true)
                term.clear()
                --centerText('WARNING: Turbine '..i..' Safety Engaged.') --Debug
            end

            --Turbine Speed Regulation
            if autoRegulateTurbineSpeed == true then
                if speed == turbineSpeedGoal then
                    --Turbine is at speed goal. Activating and engaging coils
                    turbine.setActive(true)
                    turbine.setInductorEngaged(true)
                elseif speed > turbineSpeedGoal + 25 then
                    --Turbine spinning too fast. Deactivating and engaging coils
                    turbine.setActive(false)
                    turbine.setInductorEngaged(true)
                elseif speed < turbineSpeedGoal - 25 and turbinesPoweredDown == false then
                    --Only runs if turbinesPowereDown is false (default)
                    --Turbine too slow. Activating and disengaging coils
                    turbine.setInductorEngaged(false)
                    turbine.setActive(true)
                end
            end
        end
        
        --If a key is pressed, execute command
        if keyPress(keys.zero) then
            term.clear()
            term.setCursorPos(1,1)
            term.write("Exiting controller...")
            sleep(1)
            error('Reactor Controller Closed')
        end
        if keyPress(keys.one) then
            enableAllTurbines()
            --sleep(3)
        end
        if keyPress(keys.two) then
            disableAllTurbines()
            --sleep(3)
        end
        if keyPress(keys.three) then
            engageAllTurbines()
            --sleep(3)
        end
        if keyPress(keys.four) then
            disengageAllTurbines()
            --sleep(3)
        end
    end
end

--TODO: Write a function to shut down specific turbine
--TODO: Write a function to shut down all turbines

--DEBUG
turbineCount,turbines = getTurbines()

term.clear()
print('Turbine Debug Info:')

print('DEBUG: turbine count: '..tostring(turbineCount))
print('DEBUG: turbines: '..table.concat(turbines, ", "))
--print(tostring(turbines[1]))
--debugTurbines()
-- startTurbine(1)
-- startTurbine(2)
-- startTurbine(3)

--stopAllTurbines()
--startAllTurbines()
getUserCommand()