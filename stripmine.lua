require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function strip(stripDepth, stripCount)
    for i=1,stripDepth do
        for i=1,stripCount do
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

        print("Strip of depth "..stripDepth.." returning....")
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
    turtle.turnLeft()
    for i=1,stripCount*3 do
        turtle.forward()
    end
    print("Turtle returned to start. Shutting down...")
end

print("How many strips?")
sctripCount = tonumber(read())
print("How deep are the strips?")
stripDepth = tonumber(read())
print("Mining...")

strip(5, 5)