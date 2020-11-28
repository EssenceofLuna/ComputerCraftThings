require '/ComputerCraftThings/library'


-- local x, y, z = gps.locate(5)

-- term.clear()
-- print("System Info")
-- print("Github Branch: Turtles")
-- print("Computer Label: "..os.getComputerLabel())
-- print("Computer ID: "..os.getComputerID())
-- print("Computer type: "..os.getComputerType())
-- print("Turtle Fuel: "..turtle.getFuelLevel().."/"..turtle.getFuelLimit())
-- print("OS Version: "..os.version())
-- if x ~= nil then
--     print("Coords: "..x..", "..y..", "..z)
-- else
--     print("Error: Corrdinates not obtained.")
-- end

local success, data = turtle.inspect()

if success then
    print("Block: "..data.name)
    print("Metadata: "..data.metadata)
    if data.name == "minecraft:cobblestone" then
        turtle.dig()
    end 
else
    print("No block found")
end