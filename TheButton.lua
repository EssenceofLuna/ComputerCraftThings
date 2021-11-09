--[[





    
    
    
    
    
    
What are you doing in here?
















--]]



--SETTINGS
--The side the computer expects a redstone signal for the button
--"left" "right" "front" "back" "top" or "bottom" for valid sides
BUTTON_SIDE = "right"
MONITOR_SIDE = "front"

--Whether or not to display a timer
DISPLAY_TIMER = false --broken
--Amount of time (in ticks) for each segment of the timer
--Multiply by 12 to get time until the button dies
TIME_PER_SEGMENT = 14400

display = peripheral.wrap(MONITOR_SIDE)

--The list of 12 possible colors
possibleColors = {colors.gray, colors.purple, colors.purple, colors.blue, colors.blue, colors.green, colors.green, colors.yellow, colors.yellow, colors.orange, colors.orange, colors.red}
--possibleColors = {1,2,4,8,16,32,64,128,256,512,1024,2048}

--Find player detector
detector = peripheral.find("playerDetector")
--if detector == nil then error("playerDetector not found") end

--Initial Values
loopCount = 0
buttonValue = 0
currentColor = possibleColors[1]

lastPresser = "nil"
lastPresserColor = currentColor

--Set up TheButtonBackup without writing anything to it
local h = fs.open("TheButtonBackup", "a")
h.close()

function waitForButton()
    loadState()
    while true do
        saveState()
        loadState()
        loopCount = loopCount + 1

        if (loopCount >= TIME_PER_SEGMENT) then
            increaseValue()
            loopCount = 0
        end
    
        term.redirect(display)
        term.setCursorPos(1,5)
        term.setTextColor(colors.white)
        term.clear()

        term.setTextColor(currentColor)
        print("Will you press the button?")
        drawBar()
        
        if (lastPresser ~= "nil") then
            term.setTextColor(colors.white)
            print("\n")
            print("Last pressed by: ")
            term.setTextColor(lastPresserColor)
            print(lastPresser)
        end

        if (rs.getInput(BUTTON_SIDE)) then
            resetButton()
        end

        os.sleep(1)
    
    end
end


function killButton()
    shell.run("delete TheButton.lua")
    shell.run("delete ComputerCraftThings/TheButton.lua")
    term.clear()
    print("The button has died.")
    print("\n")
    print("\n")
    os.exit()
end

function resetButton()
    --TODO: Add a fancy animation here

    term.redirect(display)
    term.setCursorPos(8,5)
    term.clear()
    term.setTextColor(currentColor)
    term.write("BUTTON PRESSED!!")

    lastPresserColor = currentColor
    lastPresser = detector.getPlayersInRange(10)[1]

    buttonValue = 0
    currentColor = possibleColors[1]


    os.sleep(3)
end

function increaseValue()
    buttonValue = buttonValue +1
    if (buttonValue >=13) then
        killButton()
    else
        currentColor = possibleColors[buttonValue]
    end
end

function drawBar()
    for i=1,12 do
        if (i <= buttonValue) then
            term.setTextColor(possibleColors[i])
            term.write("A")
        else
            term.setTextColor(colors.white)
            term.write("A")
        end
    end
end

function saveState()
    --Things to be saved/loaded:loopCount, buttonValue, currentColor, lastPresser, lastPresserColor
    
    storedValues = {loopCount, buttonValue, currentColor, lastPresser, lastPresserColor}
    
    local h = fs.open("TheButtonBackup", "w")

    h.write(textutils.serialise(storedValues))
    h.close()

    --DEBUG
    --[[print("DEBUG: Table read out (writing)")
    print(textutils.serialize(storedValues))
    os.sleep(2)--]]
end

function loadState()
    local h = fs.open("TheButtonBackup", "r")
    readValues = textutils.unserialise(h.readAll())

    --Write values to the global variables
    if(readValues ~= nil) then 
        loopCount = readValues[1]
        buttonValue = readValues[2]
        currentColor = readValues[3]
        lastPresser = readValues[4]
        lastPresserColor = readValues[5]
    end
    h.close()

    --DEBUG
    --[[print("DEBUG: Table read out (reading)")
    print(textutils.serialize(readValues))
    os.sleep(2)--]]
end

waitForButton()