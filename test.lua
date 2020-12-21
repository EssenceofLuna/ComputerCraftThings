require '/ComputerCraftThings/library'
require '/ComputerCraftThings/button'
local surface = dofile("surface") --load Surface (Graphics API)

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

-- Creates a new surface with a blue background with a size of 51x19 pixels.
local surf = surface.create(51, 19, colors.blue)

-- Draws the string "Hello, world!" at position (2,2).
surf:drawString("Hello, world!", 2, 2)

-- Outputs the surface to the screen.
surf:output()

-- Waits for a mouse click.
os.pullEvent("mouse_click")