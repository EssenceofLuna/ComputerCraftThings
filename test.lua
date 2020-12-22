require '/ComputerCraftThings/APIs/library'
-- local surface = dofile("surface")
os.loadAPI("rom/apis/textutils.lua")


-- term.clear()
-- print("System Info")
-- print("Github Branch: Master Branch")
-- print("Computer Label: "..os.getComputerLabel())
-- print("Computer ID: "..os.getComputerID())
-- print("Computer type: "..os.getComputerType())

-- turbineStr = 'BigReactors-Turbine_1'
-- turbine = peripheral.wrap(turbineStr)

-- print('Turbine Connected: '..tostring(peripheral.isPresent(turbineStr)))
-- print('Turbine Type: '..peripheral.getType(turbineStr))
-- print('Turbine Speed: '..turbine.getRotorSpeed())



-- while true do
--     event, side, xPos, yPos = os.pullEvent("monitor_touch")
--     print(event.."=> Side: "..tostring(side)..", "..
--         "X: "..tostring(xPos)..", "..
--         "Y: "..tostring(yPos))
-- end

-- term.clear()
-- local xSize, ySize = term.getSize()
-- local surf = surface.create(xSize, ySize, colors.blue)

-- surf:fillRect(5, 5, 25, 10, colors.red, colors.yellow, "@")

-- surf:output()

-- while true do
--     event, side, xPos, yPos = os.pullEvent("mouse_click")
    
--     if xPos > 5 and xPos <= 30 and yPos > 5 and yPos <= 15 then
--         surf:drawString('Button Clicked!', 5, 2, colors.blue, colors.red)
--         surf:output()
--         sleep(1)
--         surf:clear(colors.blue)
--     end
    
--     surf:fillRect(5, 5, 25, 10, colors.red, colors.yellow, "@")
--     surf:output()
-- end

--Testing Logs Functionality
-- term.clear()

-- addToLog('testLog.lua', 'Test Log', true)
-- textutils.pagedPrint(getLog('testLog.lua'))

--Testing repeat loop
-- repeat
--     print("Looped")
--     local event,key = os.pullEvent("key")
-- until key == keys.enter

local function keyPressTest()
    while true do
        local event,key = os.pullEvent("key")
        if key == keys.one then 
            print("1 pressed")
            return
        end
    end
end

local function updateScreen()
    local i = 0
    while true do
        i = i + 1
        term.setCursorPos(1,1)
        term.clearLine()
        term.write("Updating info "..i)
    end
end

parallel.waitForAny(keyPressTest, updateScreen)