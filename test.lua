require '/ComputerCraftThings/library'


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

function drawSquare(xmin,xmax,ymin,ymax,text)
    numB = ymax - ymin
    numA = xmax - xmin
    
    for i = 1,numB do
        term.setCursorPos(xmin,(ymin+i))
        print("|" .. string.rep(" ",numA-2) .. "|")
    end
    term.setCursorPos(xmin,ymin)
    print(string.rep("=",numA))
    term.setCursorPos(xmin,ymax)
    print(string.rep("=",numA))
    term.setCursorPos((numA/2) + xmin - (string.len(text)/2), ymin + (numB/2))
    print(text)
    term.setCursorPos(1,ymax+1)
end

drawSquare(5,50,5,25,'TEST BITCH')

-- while true do
--     event, side, xPos, yPos = os.pullEvent("monitor_touch")
--     print(event.."=> Side: "..tostring(side)..", "..
--         "X: "..tostring(xPos)..", "..
--         "Y: "..tostring(yPos))
-- end