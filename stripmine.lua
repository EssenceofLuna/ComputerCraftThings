require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function strip(stripDepth, stripCount)
    for i=1,stripCount do
        for i=1,stripDepth do
            --dig
            if(not checkFuel()) then
                print("Our of fuel")
                return
            end
            turtle.dig()
            turtle.digUp()
            turtle.forward()
        end
        turtle.digUp()

        manageInventory()
        print("Strip "..i.." of depth "..stripDepth.." returning....")
        --Turtle finished a strip
        turtle.turnLeft()
        turtle.turnLeft()
        for i=1,stripDepth do
            turtle.forward()
        end

        --turtle has returned to start
        if i < stripCount then
            --move to next mine
            turtle.turnLeft()
            for i=1,3 do
                turtle.dig()
                turtle.forward()
                turtle.digUp()
            end
            turtle.turnLeft()
        end
    end
    --End of mining
    print("Mining completed. Mined "..stripCount.." strips witha depth of "..stripDepth..".")
    print("Returning...")
    turtle.turnRight()
    local returnCount = (stripCount-1)*3 --How many blocks to travel to return to start
    for i=1,returnCount do
        turtle.forward()
    end
    turtle.turnRight()
    print("Turtle returned to start. Shutting down...")
end

--TODO: Make this code work when asking for player input.
--Function strip() throws an error for some reason when using user input
--Maybe switch io.read() to read()?
print("How many strips?")
stripCount = tonumber(read())
print("How deep are the strips?")
stripDepth = tonumber(read())
print("Mining...")


strip(stripDepth, stripCount)
--TODO: Once code is finished, stress test to find places where it can run out of fuel and add a fuel check there
--I expect to find one when returning when mining is finished