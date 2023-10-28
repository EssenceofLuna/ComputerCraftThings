require '/ComputerCraftThings/APIs/library'

--TODO: Write pocket computer program to check on reactor stuff

--TODI: make the turbines table a global table

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


--[[
    Function  to get info about all connected turbines
    Returns table containing a table for each turbine
    Info stored in each table is as follows:
    1 int: Turbine ID number (arbitrary but consistent, not necessarily sequential)
    2 String: name of turbine (how CC sees the turbine)
    3 Peripherl wrap: Wrap of the turbine peripheral (how CC interacts with the turbine)
    4 int: turbine rotor speed in RPM (getRotorSpeed)
    5 int: Energy generated per tick (RF/t) (getEnergyProducedLastTick)
    6 int: steam flow rate in mB/t (getFluidFlowRate)
    7 bool: whether turbine is active (using steam, increasing RPM) (getActive)
    8 bool: whether  turbine coils are engaged (generating power, lowering RPM) (getInductorEngaged)
    TODO: Make 9 and 10 work
    9 bool: whether the user has deactivated the turbine manually
    10 bool: whether the user has disengaged the turbine manually
]]
function updateTurbines()
    local turbines = {}
    --Each turbine is a table inside the turbines table
    for i=1,100 do
        --Makes a table for each turbine, then adds it to the main turbines table
        local turbineStr = 'BiggerReactors_Turbine_'..i

        if peripheral.isPresent(turbineStr) then
            --turbine is present. Get info, build a table, then add it to turbines table
            local turbine = {}

            local turbineWrap = peripheral.wrap(turbineStr) --Wrap of the turbine, used to get info and added to the table later
            
            --TODO: make ID number based on turbineStr rather than i
            table.insert(turbine, 1, i) --1
            table.insert(turbine, 2, turbineStr) --2
            table.insert(turbine, 3, turbineWrap) --3
            table.insert(turbine, 4, math.floor(turbineWrap.getRotorSpeed())) --4
            table.insert(turbine, 5, math.floor(turbineWrap.getEnergyProducedLastTick())) --5
            table.insert(turbine, 6, turbineWrap.getFluidFlowRate()) --6
            table.insert(turbine, 7, turbineWrap.getActive()) --7
            table.insert(turbine, 8, turbineWrap.getInductorEngaged()) --8


            --turbine table has been build. Adding to main turbines table
            table.insert(turbines, turbine)
        end
    end
    --Main turbines table built. Returning
    return turbines
end

--TODO: delete getTurbines once all references are removed
function getTurbines()
    --Returns a count of the turbines and a table of their names
    local turbines = {}
    
    for turbineIndex = 1,100 do --TODO: Maybe change to while loop idk
        --turbineIndex is the int value of the current check, starting at 1
        --turbineStr is the string for the peripheral name
        local turbineStr = 'BiggerReactors_Turbine_'..turbineIndex
        --print('DEBUG: Checking '..turbineIndex..' named '..turbineStr) --DEBUG
        --TODO: Convert to turbine.getConnected because it checks for multiblock and not just the computer port
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



--[[
    Returns table with info about reactor, similar to updateTurbines()
    Info stored in this table:
    1 bool: true if actively cooled (for turbines), false if passively cooled (no turbines) (getActivelyCooled)
    2 string: name of reactor (how CC sees the reactor)
    3 Peripheral wrap: wrap of the reactor peripheral (how CC interacts with the reactor)
    4 table: Contains temperatures of fuel (1) and casing (2) (getFuelTemperature and getCasingTemperature)
    5 int: Energy generated per tick (RF/t), will be 0 is actively cooled (getEnergyProducedLastTick)
    6 int: Steam produced per tick in mB/t, will be 0 if passively cooled (getHotFluidProducedLastTick)
    7 int: Fuel consumed per tick in mB/t (getFuelConsumedLastTick)
]]
function updateReactor()
    local reactor = {}

    for reactorIndex = 1,100 do
        local reactorStr = 'BiggerReactors_Reactor_'..reactorIndex
        if peripheral.isPresent(reactorStr) then
            --Valid reactor found. Building table...
            local reactorWrap = peripheral.wrap(reactorStr)

            local tempTable = {reactorWrap.getFuelTemperature(), reactorWrap.getCasingTemperature()}

            table.insert(reactor, 1, reactorWrap.getActivelyCooled()) --1
            table.insert(reactor, 2, reactorStr) --2
            table.insert(reactor, 3, reactorWrap) --3
            table.insert(reactor, 4, tempTable) --4
            table.insert(reactor, 5, reactorWrap.getEnergyProducedLastTick()) --5
            table.insert(reactor, 6, reactorWrap.getHotFluidProducedLastTick()) --6
            table.insert(reactor, 7, reactorWrap.getFuelConsumedLastTick()) --7

            return reactor
        end
    end
end




function enableAllTurbines()
    --print("Enabling all turbines.") --Debug
    local turbines = updateTurbines()
    for i=1,turbineCount do
        turbine = turbines[i][3]
        turbine.setActive(true)
        --print("Enabling Turbine "..i) --Debug
    end
    --print("All turbines enabled.") --Debug
end


function disableAllTurbines()
    local turbines = updateTurbines()
    for i=1,#turbines do
        turbine = turbines[i][3]
        turbine.setActive(false)
        --print("Disabled Turbine "..i) --Debug
    end
    --print("All turbines disabled.") --Debug
end

--Enables a single turbine
function enableTurbine(turbineId)
    local turbines = updateTurbines()
    turbineWrap = turbines[turbineId][3]
    turbineWrap.setActive(true)
end


function enableTurbine(turbineId)
    local turbines = updateTurbines()
    turbineWrap = turbines[turbineId][3]
    turbineWrap.setActive(true)
end




function engageAllTurbines()
    --TODO: convert to engageTurbine()
    local turbines = updateTurbines()
    for i=1,#turbines do
        turbineWrap = turbines[i][3]
        turbineWrap.setInductorEngaged(true)
        turbines[i][10] = false --Mark turbine as engaged
        addToLog('reactorLog', 'Engaged turbine '..turbines[i][1], true) --DebugLog
    end
end

function disengageAllTurbines()
    --TODO: convert to disengageTurbine()
    local turbines = updateTurbines()
    for i=1,#turbines do
        turbineWrap = turbines[i][3]
        turbineWrap.setInductorEngaged(false)
        turbines[i][10] = true --Mark turbine as disengaged
        addToLog('reactorLog', 'Disengaged turbine '..turbines[i][1], true) --DebugLog
    end
end


--Function to engage a single turbine
--Input int: turbine ID number (the first value dtored in a turbine's table)
function engageTurbine(turbineId)
    local turbines = updateTurbines()
    turbineWrap = turbines[turbineId][3]
    turbineWrap.setInductorEngaged(true)
    
    --single line version of function. needs testing.
    --updateTurbines()[turbineId][3].setInductorEngaged(true)
end

function disengageTurbine(turbineId)
    local turbines = updateTurbines()
    turbineWrap = turbines[turbineId][3]
    turbineWrap.setInductorEngaged(false)
    
    --single line version of function. needs testing.
    --updateTurbines()[turbineId][3].setInductorEngaged(false)
end



--This function will be called in while loops to manage turbines and display information
--Function should be called in while loop
--Offset is how many lines down to print info
--Set printInfo to true to print out turbine info (speed, flow rate, etc.)
function manageTurbines(printOffset, printInfo)
    if printOffset == nil then printOffset = 0 end
    if printInfo == nil then printInfo = false end

    local turbines = updateTurbines()

    for i=1,#turbines do
        local turbine = turbines[i][3]
        local speed = turbines[i][4]
        local flowRate = turbines[i][6]
        local energyProduced = turbines[i][5]
        if turbines[i][7] then activeText = 'Active' else activeText = 'Inactive' end
        if turbines[i][8] then engagedText = 'Engaged' else engagedText = 'Disengaged' end

        if printInfo == true then
            --Set to the line, clear it, then write new info in
            term.setCursorPos(1,printOffset+i)
            term.clearLine()
            term.write(turbines[i][1]..' '..engagedText..', '..activeText..': '..speed..' RPM, '..flowRate..' mB/t, '..energyProduced..' FE/t')
        end

        if speed > 2000 and turbines[i][7] and turbines[i][8] == false then
            --Turbine at risk of melting down. Engaging coils
            turbine.setInductorEngaged(true)
            term.clear()
            --centerText('WARNING: Turbine '..i..' Safety Engaged.') --Debug
        end

        --Turbine Speed Regulation
        --If turbines was manually disabled/disengaged, this will not modify that
        --TODO: Write code to enable/disable specific turbines which handles checking for manual didengagement

        --TODO, High priority: Currently ignores if user has manually disengaged/deactivated turbine
        --This is because updateTurbines() doesn't have a way to add that info into it
        --Need to find a way to pass this to updateTurbines()
        if autoRegulateTurbineSpeed == true then
            if speed == turbineSpeedGoal then
                --Turbine is at speed goal. Activating and engaging coils
                if turbines[i][9] ~= true then turbine.setActive(true) end
                if turbines[i][10] ~= true then turbine.setInductorEngaged(true) end
                addToLog('reactorLog', 'Speed goal met on turbine '..turbines[i][1], true) --DebugLog
            elseif speed > turbineSpeedGoal + 25 then
                --Turbine spinning too fast. Deactivating and engaging coils
                if turbines[i][9] ~= true then turbine.setActive(false) end
                if turbines[i][10] ~= true then turbine.setInductorEngaged(true) end
                addToLog('reactorLog', 'Speed exceded goal on turbine '..turbines[i][1], true) --DebugLog
            elseif speed < turbineSpeedGoal - 25 then
                --Only runs if turbinesPowereDown is false (default)
                --Turbine too slow. Activating and disengaging coils
                if turbines[i][9] ~= true then turbine.setActive(true) end
                if turbines[i][10] ~= true then turbine.setInductorEngaged(false) end
                addToLog('reactorLog', 'Speed under goal on turbine '..turbines[i][1], true) --DebugLog
            end
        end
    end
end



function getUserCommand()
    local turbineCount,turbines = getTurbines() --TODO: delete this line after checking if its necessary
    term.clear()
    while true do
        local turbineSpeeds = {}
        for i=1,turbineCount do
          --TODO: delete this for loop after making sure its not needed
          
            --Put current turbine speeds into table turbineSpeeds which correspond with their locations in turbines
            local turbineStr = turbines[i]
            local turbine = peripheral.wrap(turbineStr)
            local speed = math.floor(turbine.getRotorSpeed())
            table.insert(turbineSpeeds, i, speed)
        end

        --term.clear()
        --TODO: Add functionality to  start/stop specific turbine. To do this, index all the turbines and list then to let the user pick one
        
        --term.setCursorPos(1,1)
        --centerText("[Reactor Controller]")
        setWrite("Select a command",1,1)
        setWrite("9) Exit Program",1,2)
        setWrite("1) Turbine Menu",1,3)
        -- setWrite("1) Activate All Turbines",1,3)
        -- setWrite("2) Deactivate All Turbines",1,4)
        -- setWrite("3) Engage All Turbines",1,5)
        -- setWrite("4) Disengage All Turbines",1,6)

        setWrite("Turbines:",1,8)
        
        --TODO: Add support for reactor info (active and passive)

        --Runs once for each connected turbine
        manageTurbines(8, true)
        
        --If a key is pressed, execute command
        if keyPress(keys.nine) then
            term.clear()
            term.setCursorPos(1,1)
            term.write("Exiting controller...")
            sleep(1)
            error('Reactor Controller Closed')
        end
        if keyPress(keys.one) then
            --Turbine Control Menu
            term.clear()
            while true do
                term.setCursorPos(1,1)
                term.clearLine()
                centerText('Turbine Menu')
                
                setWrite('0) Back',1,2)
                setWrite('1) Enable All Turbines',1,3)
                setWrite('2) Disable All Turbines',1,4)
                setWrite('3) Engage All Turbines',1,5)
                setWrite('4) Disengage All Turbines',1,6)

                manageTurbines(8, true)


                if keyPress(keys.zero) then
                    term.clear()
                    break
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
    end
end

--TODO: Write a function to shut down specific turbine

getUserCommand()