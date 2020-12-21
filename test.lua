require '/ComputerCraftThings/library'
os.loadAPI("button")
button.setMonitor(top)

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

testButton = button.create("Test Button")
testButton.setPos(1,1)
testButton.onClick(function() print("Button Clicked") end)
while true do button.await(myButton) end