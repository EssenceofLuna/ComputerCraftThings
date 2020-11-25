require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function strip(depth, count)
    for i=1,tonumber(count) do
        for i=1,tonumber(depth) do
            --dig
            checkFuel()
            turtle.dig()
            turtle.digUp()
            turtle.forward()
        end
        turtle.digUp()

        print("Strip of depth "..depth.." returning....")
        --Turtle finished a strip
        turtle.turnLeft()
        turtle.turnLeft()
        for i=1,tonumber(depth) do
            turtle.forward()
        end

        --turtle has returned to start
        if i < count then
            --move to next mine
            turtle.turnLeft()
            for i=1,3 do
                turtle.dig()
                turtle.forward()
                turtle.digUp()
            end
        end
    end
end

print("How many strips?")
sctripCount = io.read()
print("How deep are the strips?")
stripDepth = io.read()
print("Mining...")

strip(stripDepth)