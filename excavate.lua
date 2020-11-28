require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function excavate(depth, width)
    manageInventory()
    for i=1,width do
        turtle.digForward(depth)
        turtle.turnRight()
        turtle.digForward()
        turtle.turnRight()
    end
end

excavate(10, 5)