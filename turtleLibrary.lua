local SLOT_COUNT = 16

--TODO: Add settings command to edit what items to drop
--Unwanted items
DROPPED_ITEMS = {
    "minecraft:stone",
    "minecraft:dirt",
    "minecraft:cobblestone",
    "minecraft:sand",
    "minecraft:gravel",
    --"minecraft:redstone",
    "minecraft:flint",
    "railcraft:ore_metal",
    "extrautils2:ingredients",
    "minecraft:dye",
    "thaumcraft:nugget",
    "thaumcraft:crystal_essence",
    "thermalfoundation:material",
    "projectred-core:resource_item",
    "thaumcraft:ore_cinnabar",
    "deepresonance:resonating_ore",
    "forestry:apatite"
}

--Items to be kept in the turtle's inventory
KEPT_ITEMS = {
    "minecraft:coal",
    "minecraft:coal_block",
    "minecraft:torch",
    "enderstorage:ender_storage"
}

function dropItems()
    --Credit to Micheal Reeves
    print("Purging Inventory...")
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            for filterIndex = 1, #DROPPED_ITEMS, 1 do
                if(item["name"] == DROPPED_ITEMS[filterIndex]) then
                    print("Dropping - " .. item["name"])
                    turtle.select(slot)
                    turtle.dropDown()
                end
            end
        end
    end
end

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

function getTorchIndex()
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if(item["name"] == "minecraft:torch") then
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
    --TODO: Add a catch for when no ender chest is found
    -- Chest is now deployed
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if tableContains(KEPT_ITEMS, item["name"]) == false then
                --If item is not on list of KEPT_ITEMS, then store in chest
                --TODO: Limit how much fuel to keep on hand at one time
                print("Storing - " .. item["name"])
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