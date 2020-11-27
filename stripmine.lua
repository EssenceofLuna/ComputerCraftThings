require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

function initialCheck()
    --TODO: Write this
    --Function that checks for fuel, ender chest, and torches.
    --If no torches, warn user that it will be dark and ask to continue
    --If no Echest/fuel, throw error and cancel. Maybe error() idk
end

function strip(stripDepth, stripCount)
    manageInventory()
    for i=1,stripCount do
        for i=1,stripDepth do
            --dig
            -- if(not checkFuel()) then
            --     print("Out of fuel")
            --     return
            -- end
            -- turtle.dig()
            -- turtle.digUp()

            --Torch placement
            if i % 10 == 0 then
                --print("Attempting torch placement...") --Debug
                --Place torch every 10 blocks
                local index = getItemIndex("minecraft:torch")
                if(index ~= nil) then
                    --TODO: Torch placing is currently directional
                    --Possible solution: Place on ground instead
                    --Possible solution: Go up, break block, go down and place torch
                    --print("Torch found. Placing...") --Debug
                    turtle.select(index)     
                    turtle.placeUp()
                    
                else
                    --No torch found
                    print("Error placing torch: Torch not found") --Debug
                end
            end
            turtle.digForward()

            -- while turtle.detect() do
            --     --Sand/Gravel handler
            --     print("GRAVEL DETECTED!") --Debug
            --     turtle.dig()
            --     sleep(0.5)
            -- end
            -- if turtle.detectDown() ~= true then
            --     print("No floor detected. Solving...") --Debug
            --     --Find a block to be used
            --     if getItemIndex("minecraft:cobblestone") ~= nil then
            --         --Place ground using cobblestone
            --         local blockIndex = getItemIndex("minecraft:cobblestone")
            --         turtle.select(blockIndex)
            --         turtle.placeDown()
            --     else
            --         print("No cobblestone found. Not building floor.")
            --     end
            -- end

            -- turtle.forward()
            --manage inventory every 30 blocks
            if i % 30 == 0 then
                manageInventory()
            end
        end
        -- turtle.digUp()

        --manageInventory() --Not sure if needed
        print("Strip "..i.." of "..stripCount.." completed.")
        --Turtle finished a strip
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.moveForward(stripDepth)
        -- for i=1,stripDepth do
        --     --TODO: Possible bug where turtle infinitely digs away from strip
        --     while turtle.detect() do
        --         print("Obstruction detected while returning!") --Debug
        --         turtle.dig()
        --         sleep(0.5)
        --     end

        --     turtle.forward()
            
        --     if(not checkFuel()) then
        --         print("Out of fuel")
        --         return
        --     end
        -- end

        --turtle has returned to start
        if i < stripCount then
            --move to next mine
            turtle.turnLeft()
            turtle.moveForward(3)
            -- for i=1,3 do
            --     turtle.dig()
            --     while turtle.detect() do
            --         --Sand/Gravel handler
            --         print("GRAVEL DETECTED!") --Debug
            --         turtle.dig()
            --         sleep(0.5)
            --     end
            --     turtle.forward()
            --     turtle.digUp()
            -- end
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
        if(not checkFuel()) then
            print("Out of fuel")
            return
        end
    end
    turtle.turnRight()
    manageInventory()
    print("Turtle returned to start. Shutting down...")
end

print("How many strips?")
stripCount = tonumber(read())
print("How deep are the strips?")
stripDepth = tonumber(read())
print("Mining...")


strip(stripDepth, stripCount)
--TODO: Once code is finished, stress test to find places where it can run out of fuel and add a fuel check there
--I expect to find one when returning when mining is finished

--TODO: The starts of the strips are dark. Need to make it place torches at the start of every few strips

--TODO: Rewrite all movement to a move function, maybe mineForward(), that detects gravel and ground below

--TODO: Add settings for things like placing floor, placing torches, etc.

--TODO: Add a check for stripCount and stripDepth to be numbers. Maybe a while loop until a number is entered