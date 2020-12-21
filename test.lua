require '/ComputerCraftThings/library'
local surface = dofile("surface")


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

term.clear()

local surf = surface.create(51, 19, colors.blue)

surf:fillRect(5, 5, 25, 10, colors.red, colors.yellow, "@")

surf:output()

while true do
    event, side, xPos, yPos = os.pullEvent("mouse_click")
    
    if xPos >= 5 and xPos <= 25 and yPos >= 5 and yPos <= 10 then
        surf:drawString('Button Clicked!', 2, 2, colors.blue, colors.red)
        surf:output()
        sleep(1)
        surf:clear(colors.blue)
    end
    
    surf:fillRect(5, 5, 25, 10, colors.red, colors.yellow, "@")
    surf:output()
end