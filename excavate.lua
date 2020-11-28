require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function excavate(depth, width)
    manageInventory()
    for i=1,width do
        turtle.digForward(depth)
        turtle.turnRight()
        turtle.turnRight()
        turtle.moveForward(depth)

        turtle.turnLeft()
        turtle.digForward()
        turtle.turnLeft()
    end
end

excavate(10, 5)