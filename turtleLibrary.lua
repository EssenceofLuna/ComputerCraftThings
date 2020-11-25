local SLOT_COUNT = 16

function getEnderIndex()
    --Credit to Micheal Reeves
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if(item["name"] == "enderstorage:ender_storage") then
                return slot
            end
        end
    end
    return nil
end
 
function manageInventory()
    --Credit to Micheal Reeves
    dropItems()
    index = getEnderIndex()
    if(index ~= nil) then
        turtle.select(index)
        turtle.digUp()      
        turtle.placeUp()  
    end
    -- Chest is now deployed
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if(item["name"] ~= "minecraft:coal_block" and item["name"] ~= "minecraft:coal") then
                turtle.select(slot)
                turtle.dropUp()
            end
        end
    end
    -- Items are now stored
 
    turtle.digUp()
end

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