require '/ComputerCraftThings/library'
require '/ComputerCraftThings/turtleLibrary'

--SETTINGS
autoPlaceFloor = false
autoPlaceTorch = true

function excavate(depth, width)
    manageInventory()
    for columns=1,width do
        for rows=1,depth do
            --manage inventory every 30 blocks
            if rows % 30 == 0 then
                manageInventory()
            end
            turtle.digForward()
            if autoPlaceTorch == true and columns % 5 == 0 and rows % 5 == 0 then
                print("Placing torch...") --Debug
                --Torch placement in 5x5 grid
                local torchIndex = getItemIndex("minecraft:torch")

                turtle.back()
                turtle.place(torchIndex)
                turtle.forward()
            end
        end
        
        if columns == 1 then
            depth = depth - 1
        end

        turtle.turnRight()
        turtle.turnRight()
        turtle.moveForward(depth)
        
        manageInventory()
        
        if columns ~= width then
            --Turn to next row
            turtle.turnLeft()
            turtle.digForward()
            turtle.turnLeft()
        end
        print("Column "..columns.." of "..width.." completed.")
    end
    
    --Finished excavating. Returning to start
    turtle.turnRight()
    turtle.moveForward(width-1)
    turtle.turnRight()
    turtle.back()

end

-- print("How many strips?")
-- stripCount = tonumber(read())
-- print("How deep are the strips?")
-- stripDepth = tonumber(read())
-- print("Mining...")
term.clear()
print("Enter depth and width of excavation (in front of turtle)")
print("Enter Depth")
depth = tonumber(read())
term.clear()
print("Enter depth and width of excavation (in front of turtle)")
print ("Enter width (to right)")
width = tonumber(read())
term.clear()
print("Excavation started")

excavate(depth, width)

term.clear()
print("Excavation of "..depth.."x"..width.." complete.")