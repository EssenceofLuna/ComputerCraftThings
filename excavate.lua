require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function excavate(depth, width)
    manageInventory()
    for i=1,width do

        if i == 2 then
            depth = depth - 1
        end

        for i=1,depth do
            --manage inventory every 30 blocks
            if i % 30 == 0 then
                manageInventory()
            end
            turtle.digForward()
        end

        turtle.turnRight()
        turtle.turnRight()
        turtle.moveForward(depth)

        manageInventory()
        
        if i ~= width then
            --Turn to next row
            turtle.turnLeft()
            turtle.digForward()
            turtle.turnLeft()
        end
    end

    --Finished excavating. Returning to start
    turtle.turnRight()
    turtle.moveForward(width-1)
    turtle.turnRight()
end

excavate(5, 5)