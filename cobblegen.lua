require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

--SETTINGS
CHEST_SIDE = "left"


while true do
    for i=1,63 do
        turtle.dig()
    
    if CHEST_SIDE == "left" do
        turtle.turnLeft()
        if turtle.detect() == "minecraft:chest" do
            getItemIndex("minecraft:cobblestone") 
            turtle.drop()