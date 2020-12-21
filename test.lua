require '/ComputerCraftThings/library'
require '/ComputerCraftThings/button'
surface = dofile("surface") --load Surface (Graphics API)

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

-- Loads the color.bmp image.
local surf = surface.load("home/color.bmp")
-- Converts the colours from RGB to CC, with dithering.
surf:toPalette(surface.palette.cc, true)

-- Creates the screen surface.
local screen = surface.create(57, 19)
-- Draws the image surface with smaller pixels.
screen:drawSurfaceSmall(surf, 0, 0)

-- Outputs the screen surface.
screen:output()
-- Waits for a mouse click.
os.pullEvent("mouse_click")