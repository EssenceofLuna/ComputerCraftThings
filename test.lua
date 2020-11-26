require '/ComputerCraftThings/library'

term.clear()
print("System Info")
print("Github Branch: Turtles")
print("Computer Label: "..os.getComputerLabel())
print("Computer ID: "..os.getComputerID())
print("Computer type: "..os.getComputerType())
print("Turtle Fuel: "..turtle.getFuelLevel().."/"..turtle.getFuelLimit())