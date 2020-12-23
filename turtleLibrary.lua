local SLOT_COUNT = 16 --should always be 16
--[[
   

    SETTINGS


]]--
autoPlaceFloor = true

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
    --"thaumcraft:crystal_essence",
    --"thermalfoundation:material",
    "projectred-core:resource_item",
    --"thaumcraft:ore_cinnabar",
    --"deepresonance:resonating_ore",
    "forestry:apatite"
}

--Items to be kept in the turtle's inventory
KEPT_ITEMS = {
    "minecraft:coal",
    "minecraft:coal_block",
    "minecraft:torch",
    --"enderstorage:ender_storage" --Note: Don't need to keep echests unless you want more than 1
}

--TODO: Add a settings menu to allow adding ores
ORES = {
    --Minecraft
    "minecraft:coal_ore",
    "minecraft:iron_ore",
    "minecraft:gold_ore",
    "minecraft:diamond_ore",
    "minecraft:redstone_ore",
    "minecraft:emerald_ore",
    "minecraft:lapis_ore",
    "minecraft:quartz_ore",
    --Thermal Foundation
    "thermalfoundation:ore",
    "thermalfoundation:ore:1",
    "thermalfoundation:ore:2",
    "thermalfoundation:ore:3",
    "thermalfoundation:ore:4",
    "thermalfoundation:ore:5",
    "thermalfoundation:ore:6",
    "thermalfoundation:ore:7",
    "thermalfoundation:ore:8",
    "thermalfoundation:ore_fluid",
    "thermalfoundation:ore_fluid:1",
    "thermalfoundation:ore_fluid:2",
    "thermalfoundation:ore_fluid:3",
    "thermalfoundation:ore_fluid:4",
    "thermalfoundation:ore_fluid:5",
    --Railcraft
    "railcraft:ore_magic",
    "railcraft:ore_metal",
    "railcraft:ore_metal:1",
    "railcraft:ore_metal:2",
    "railcraft:ore_metal:3",
    "railcraft:ore_metal:4",
    "railcraft:ore_metal:5",
    "railcraft:ore_metal_poor",
    "railcraft:ore_metal_poor:1",
    "railcraft:ore_metal_poor:2",
    "railcraft:ore_metal_poor:3",
    "railcraft:ore_metal_poor:4",
    "railcraft:ore_metal_poor:5",
    "railcraft:ore_metal_poor:6",
    "railcraft:ore_metal_poor:7",
    --Draconic Evolution
    "draconicevolution:draconium_ore",
    "draconicevolution:draconium_ore:1",
    "draconicevolution:draconium_ore:2",
    --IC2
    "ic2:resource:1",
    "ic2:resource:2",
    "ic2:resource:3",
    "ic2:resource:4",
    --Big Reactors
    "bigreactors:oreyellorite",
    "bigreactors:oreanglesite",
    "bigreactors:orebenitoite",
    --Aroma1997's Dimensional World
    "aroma1997sdimension:miningore",
    "aroma1997sdimension:miningore:1",
    --Actually Additions
    "actuallyadditions:block_misc:3",
    --Immersive Engineering
    "immersiveengineering:ore",
    "immersiveengineering:ore:1",
    "immersiveengineering:ore:2",
    "immersiveengineering:ore:3",
    "immersiveengineering:ore:4",
    --Project Red
    "projectred-exploration:ore",
    "projectred-exploration:ore1",
    "projectred-exploration:ore2",
    "projectred-exploration:ore3",
    "projectred-exploration:ore4",
    "projectred-exploration:ore5",
    "projectred-exploration:ore6",
    --Tinker's Construct
    "tconstruct:ore",
    "tconstruct:ore1",
    --Applied Energistics 2
    "appliedenergistics2:quartz_ore",
    "appliedenergistics2:charged_quartz_ore",
    --Forestry
    "forestry:resources",
    "forestry:resources:1",
    "forestry:resources:2",
    --Biomes O' Plenty
    "biomesoplenty:gem_ore",
    "biomesoplenty:gem_ore:1",
    "biomesoplenty:gem_ore:2",
    "biomesoplenty:gem_ore:3",
    "biomesoplenty:gem_ore:4",
    "biomesoplenty:gem_ore:5",
    "biomesoplenty:gem_ore:6",
    "biomesoplenty:gem_ore:7",
    --RFTools
    "rftools:dimensional_shard_ore",
    "rftools:dimensional_shard_ore:1",
    "rftools:dimensional_shard_ore:2",
    --Deep Resonance
    "deepresonance:resonating_ore",
    "deepresonance:resonating_ore:1",
    "deepresonance:resonating_ore:2",
    --Thaumcraft
    "thaumcraft:ore_amber",
    "thaumcraft:ore_cinnabar",
    "thaumcraft:ore_quartz"
}
--TODO: Verify that EnderIO doesn't have any ores

--TODO: Make a table of items to be used as building blocks like cobblestone

--[[


    TURTLE INVENTORY MANAGEMENT


]]--

--TODO: Keep 1 stack of cobblestone if autoPlaceFloor is true
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

--OLD: Replaced by getItemIndex()
-- function getEnderIndex()
--     --Credit to Micheal Reeves
--     for slot = 1, SLOT_COUNT, 1 do
--         local item = turtle.getItemDetail(slot)
--         if(item ~= nil) then
--             if(item["name"] == "enderstorage:ender_storage") then
--                 return slot
--             end
--         end
--     end
--     return nil
-- end

--OLD: Replaced by getItemIndex()
-- function getTorchIndex()
--     for slot = 1, SLOT_COUNT, 1 do
--         local item = turtle.getItemDetail(slot)
--         if(item ~= nil) then
--             if(item["name"] == "minecraft:torch") then
--                 return slot
--             end
--         end
--     end
--     return nil
-- end

function getItemIndex(itemName)
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if(item["name"] == itemName) then
                return slot
            end
        end
    end
    return nil
end
 
function manageInventory()
    --Credit to Micheal Reeves
    dropItems()
    index = getItemIndex("enderstorage:ender_storage")
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

--[[


    TURTLE MOVEMENT


]]--

--Moves turtle to specific coordinates
function gotoCoords(xTarget, yTarget, zTarget)
    --TODO: Finish this
    --Need to figure out which way turtle is facing before moving more
    local x, y, z = gps.locate()
    if x ~= nil then
        --Move up or down to match Y level
        while y>yTarget do
            turtle.up()
            y = y + 1
        end
        while y<yTarget do
            turtle.down()
            y = y - 1
        end
    else
        --TODO: Figure out what to return when an error happens
        return
    end
end

--Function to check if ground is below turtle, and place block is no ground found
--NOTE: autoPlaceFloor must be set to true for floor to be placed
function turtle.groundCheck(block)
    if block == nil then
        --If no block specified, then use cobblestone
        block = "minecraft:cobblestone"
    end

    --Ground detection
    if turtle.detectDown() ~= true and autoPlaceFloor == true then
        --print("No floor detected. Solving...") --Debug
        --Find a block to be used
        if getItemIndex(block) ~= nil then
            --Place ground using cobblestone
            local blockIndex = getItemIndex(block)
            turtle.select(blockIndex)
            turtle.placeDown()
        else
            print("No "..block.." found. Not building floor.")
        end
    end
end

--Go forward with ground and gravel detection
function turtle.moveForward(distance)
    if distance == nil then
        --If no distance specified, only run once
        distance = 1
    end
    
    for i=1,distance do
        --Refuel
        if(not checkFuel()) then
            print("Out of fuel")
            return
        end
        
        turtle.groundCheck()
        
        --Sand/Gravel handler
        while turtle.detect() do
            if getBlockName() ~= "minecraft:torch" then --Ignore torches
                print("GRAVEL DETECTED!") --Debug
                turtle.dig()
                sleep(0.5)
            end
        end
        
        --Move forward once all checks are done, then dig up
        turtle.forward()
    end
end

--TODO: Add entity detection/smacking to turtle move and dig functions

--Same as turtle.goForward, but digs a tunnel as it goes
function turtle.digForward(distance)
    if distance == nil then
        --If no distance specified, only run once
        distance = 1
    end

    for i=1,distance do
        --Refuel
        if(not checkFuel()) then
            print("Out of fuel")
            return
        end

        turtle.groundCheck()
        
        turtle.dig()
        
        --Sand/Gravel handler
        while turtle.detect() do
            if getBlockName() ~= "minecraft:torch" then --Ignore torches
                print("GRAVEL DETECTED!") --Debug
                turtle.dig()
                sleep(0.5)
            end
        end
        
        --Move forward once all checks are done, then dig up
        turtle.forward()
        turtle.digUp()
    end
end

function getBlockName(direction)
    --TODO: Add direction support
    local success, data = turtle.inspect()

    if success then
        if data.metadata ~= 0 then
            --Block has metadata (like stone variants)
            return data.name..":"..data.metadata
        else
            return data.name
        end
    else
        return "No block found"
    end
end

--Equip an item to the turtle, defaults to left side
--Returns true/false if success/failed
function equipItem(item, side)
    if side == nil then
        side = 'left'
    elseif side ~= nil and side ~= 'left' and side ~=  'right' then
        --No valid side entered
        print("Error: Attempted to equip item at side: "..side)
        return false
    end
    --Set both to lowercase
    item = string.lower(item)
    side = string.lower(side)
    --TODO: Add a list of valid items

    local index = getItemIndex(item)
    if index ~= nil then
        --Everything worked well. Attempts to equip the item
        turtle.select(index)
        if side == 'right' then
            turtle.equipRight()
            return true
        elseif side == 'left' then
            turtle.equipLeft()
            return true
        else
            print("Unknown error occurred while equipping item: "..item.." at side: "..side)
            return false
        end
    else
        print("Error: Tried to switch to invalid item: "..item)
        return false
    end
end