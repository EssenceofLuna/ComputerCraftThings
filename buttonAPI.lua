require '/ComputerCraftThings/library'
local surface = dofile("surface")
--Abandoned project, basically
--Get size of screen and draw a canvas
local xSize, ySize = term.getSize()
local surf = surface.create(xSize, ySize)

function drawButton(xStart, yStart, width, height, color, textStr, textColor)
    surf:fillRect(xStart, yStart, width, height, color)
    surf
end