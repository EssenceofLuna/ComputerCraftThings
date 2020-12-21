require '/ComputerCraftThings/APIs/library'

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
    --TODO: When a turbine is done, all turbine numbers shift down to fill in. Maybe get turbine number from the string rather than i?
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




function stopAllTurbines()
    print("Stopping all turbines.")
    local turbineCount,turbines = getTurbines()
    for i=1,turbineCount do
        turbineStr = turbines[i]
        turbine = peripheral.wrap(turbineStr)
        turbine.setActive(false)
        --print("Stopped Turbine "..i) --Debug
    end
    --print("All turbines stopped.") --Debug
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
        term.setCursorPos(1,1)
        centerText("Select a command")
        term.setCursorPos(1,2)
        term.write("0) Exit Program")
        term.setCursorPos(1,3)
        term.write("1) Start All Turbines")
        term.setCursorPos(1,4)
        term.write("2) Stop All Turbines")
        term.setCursorPos(1,5)
        term.write("3) Engage All Turbines")
        term.setCursorPos(1,6)
        term.write("4) Disengage All Turbines")

        --Print Turbine Info
        for i=1,turbineCount do
            local turbineStr = turbines[i]
            local turbine = peripheral.wrap(turbineStr)
            local speed = math.floor(turbine.getRotorSpeed())
            local flowRate = turbine.getFluidFlowRate()
            if turbine.getActive() then activeText = 'Active' else activeText = 'Inactive' end
            if turbine.getInductorEngaged() then engagedText = 'Engaged' else activeText = 'Disengaged' end

            --Set to the line, clear it, then write new info in
            term.setCursorPos(1,7+i)
            term.clearLine()
            term.write('Turbine '..i..' '..engagedText..', '..activeText..': '..speed..' RPM, '..flowRate..' mB/t')
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
            startAllTurbines()
            sleep(3)
        end
        if keyPress(keys.two) then
            stopAllTurbines()
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