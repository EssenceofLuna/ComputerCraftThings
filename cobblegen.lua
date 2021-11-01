require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

--SETTINGS
CHEST_SIDE = "left"


while true do
    for i=1,63 do
        turtle.dig()
    end
    
    if CHEST_SIDE == "left" then
        turtle.turnLeft()
        if turtle.detect() == "minecraft:chest" then
            getItemIndex("minecraft:cobblestone") 
            turtle.drop()
        end
    end
end