--[[





    
    
    
    
    
    
What are you doing in here?
















--]]



--SETTINGS
--The side the computer expects a redstone signal for the button
--"left" "right" "front" "back" "top" or "bottom" for valid sides
BUTTON_SIDE = "right"
MONITOR_SIDE = "top"

--Whether or not to display a timer
DISPLAY_TIMER = true
--Amount of time (in ticks) for each segment of the timer
--Multiply by 12 to get time until the button dies
TIME_PER_SEGMENT = 2

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

lastPresser = nil
lastPresserColor = currentColor

--Set up TheButtonBackup without writing anything to id
local h = fs.open("TheButtonBackup", "a")
h.close()

function waitForButton()
    while true do
        loadState()
        loopCount = loopCount + 1
    
        --term.redirect(display)
        term.setCursorPos(1,5)
        term.setTextColor(colors.white)
        term.clear()

        term.setTextColor(currentColor)
        print("Will you press the button?")
        drawBar()
        
        if (lastPresser ~= nil) then
            term.setTextColor(colors.white)
            print("\n")
            print("Last pressed by: ")
            term.setTextColor(lastPresserColor)
            print(lastPresser)
        end

        if (rs.getInput(BUTTON_SIDE)) then
            resetButton()
        end

        saveState()
        os.sleep(1)
    
        if (loopCount >= TIME_PER_SEGMENT) then
            increaseValue()
            loopCount = 0
        end
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

    --term.redirect(display)
    term.setCursorPos(8,5)
    term.clear()
    term.setTextColor(currentColor)
    term.write("BUTTON PRESSED!!")

    lastPresserColor = currentColor
    lastPresser = detector.getPlayersInRange(5)[1]

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

    h.write(storedValues)
    h.close()
end

function loadState()
    local h = fs.open("TheButtonBackup", "r")
    readValues = h.read()

    --Write values to the global variables
    if(readValues ~= nil) then 
        loopCount = readValues[1]
        buttonValue = readValues[2]
        currentColor = readValues[3]
        lastPresser = readValues[4]
        lastPresserColor = readValues[5]
    end
end

waitForButton()

--[[for loopCount=1,12 do
    print("Start loop: "..loopCount.."/".."12")

    --TODO: Convert the following into a table or something
    if(loopCount == 1) then
        print("DEBUG: loopCount 1, Color set to purple")
        currentColor = "purple"
    elseif(loopCount == 2) then
        print("DEBUG: loopCount 2, Color set to purple")
        currentColor = "purple"
    elseif(loopCount == 3) then
        print("DEBUG: loopCount 3, Color set to purple")
        currentColor = "purple"
    elseif(loopCount == 4) then
        print("DEBUG: loopCount 4, Color set to blue")
        currentColor = "blue"
    elseif(loopCount == 5) then
        print("DEBUG: loopCount 5, Color set to blue")
        currentColor = "blue"
    elseif(loopCount == 6) then
        print("DEBUG: loopCount 6, Color set to green")
        currentColor = "green"
    elseif(loopCount == 7) then
        print("DEBUG: loopCount 7, Color set to green")
        currentColor = "green"
    elseif(loopCount == 8) then
        print("DEBUG: loopCount 8, Color set to yellow")
        currentColor = "yellow"
    elseif(loopCount == 9) then
        print("DEBUG: loopCount 9, Color set to yellow")
        currentColor = "yellow"
    elseif(loopCount == 10) then
        print("DEBUG: loopCount 10, Color set to orange")
        currentColor = "orange"
    elseif(loopCount == 11) then
        print("DEBUG: loopCount 11, Color set to orange")
        currentColor = "orange"
    elseif(loopCount == 12) then
        print("DEBUG: loopCount 12, Color set to red")
        currentColor = "red"
    end

    term.write("DEBUG: Current color: ")
    term.setTextColor(colors.purple)
    print(currentColor)
    term.setTextColor(colors.white)

    if (DISPLAY_TIMER == true) then
        print("Time remaining: "..(12-loopCount)*TIME_PER_SEGMENT.." seconds")
    end

    os.sleep(TIME_PER_SEGMENT)
end--]]