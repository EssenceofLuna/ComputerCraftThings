require '/ComputerCraftThings/library'

-- term.clear()
-- print("System Info")
-- print("Github Branch: Master Branch")
-- print("Computer Label: "..os.getComputerLabel())
-- print("Computer ID: "..os.getComputerID())
-- print("Computer type: "..os.getComputerType())

turbineStr = 'BigReactors-Turbine_0'

print('Turbine Connected: '..tostring(peripheral.isPresent(turbineStr)))
print('Turbine Type: '..peripheral.getType(turbineStr))