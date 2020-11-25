require '/ComputerCraftThings/library'

local SLOT_COUNT = 16

--Credit to Micheal Reeves
function checkFuel()
    turtle.select(1)
 
    if(turtle.getFuelLevel() < 50) then
        print("Attempting Refuel...")
        for slot = 1, SLOT_COUNT, 1 do
            turtle.select(slot)
            if(turtle.refuel(1)) then
                return true
            end
        end
 
        return false
    else
        return true
    end
end

function strip(depth)
    for i=1,tonumber(depth) do
        checkFuel()
        turtle.dig()
        turtle.digUp()
        turtle.forward()
    end
    turtle.digUp()
    print("Strip of depth "..depth.." completed.")
end

print("How many strips?")
sctripCount = io.read()
print("How deep are the strips?")
stripDepth = io.read()
print("Mining...")

strip(stripDepth)