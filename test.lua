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

term.clear()
addToLog('testLog.lua', 'Test Log '..os.time(os.date("%d.%m.%Y %H:%M")))
textutils.pagedPrint(getLog('testLog.lua'))