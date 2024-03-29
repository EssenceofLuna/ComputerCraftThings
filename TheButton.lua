--[[





    
    
    
    
    
    
What are you doing in here?
















--]]



--TODO for V2:
-- Implement the currently unused DISPLAY_TIMER setting A.K.A. add a way to display timer.
-- Add a function to track and save when a button is pressed (function done, just needs implementation)
-- Replace deleting file with shell.getRunningProgram
-- Store code, backups, scores, etc. off-site (on another computer) to avoid peaking
-- Add a setting to toggle above



--SETTINGS



--The side the computer expects a redstone signal for the button
--"left" "right" "front" "back" "top" or "bottom" for valid sides
BUTTON_SIDE = "right"

--Whether or not to display a timer
DISPLAY_TIMER = false --Not implemented

--Amount of time (in seconds) for each segment of the timer
--Multiply by 12 to get time until the button dies
TIME_PER_SEGMENT = 3

--Whether or not the PC should show who last pressed the button
--NEEDS TESTING!!!
SHOW_LAST_PRESSER = true

--Whether or not to save when the button is pressed to a file
SAVE_SCORES = true

--Whether or not to draw timer
--Unfinished
SHOW_TIMER = true

--Whether or not to delete self when the button dies (for debugging)
DELETE_SELF = false



--INITIAL SETUP



--Check for a monitor as set to use it if found
display = peripheral.find("monitor")
if display == nil then
    --No monitor found
    display_on_monitor = false
else
    display_on_monitor = true
end


--The list of 12 possible colors
possibleColors = {colors.gray, colors.purple, colors.purple, colors.blue, colors.blue, colors.green, colors.green, colors.yellow, colors.yellow, colors.orange, colors.orange, colors.red}

--Find player detector
detector = peripheral.find("playerDetector")
--if detector == nil then error("playerDetector not found") end

--Initial Values (overwritten if TheButtonBackup exists)
loopCount = 0
buttonValue = 0
currentColor = possibleColors[1]

lastPresser = "nil"
lastPresserColor = currentColor

--Set up TheButtonBackup without writing anything to it
local h = fs.open("TheButtonBackup", "a")
h.close()

--Main looping function
function waitForButton()
    loadState()
    while true do
        saveState()
        loadState()

        if(checkForPlayers(160 )~= nil) then
            --Only progress if a player is within range (10 chunks)
            --NEEDS TESTING!!!
            loopCount = loopCount + 1
        end

        if (loopCount >= TIME_PER_SEGMENT) then
            increaseValue()
            loopCount = 0
        end
    
        if display_on_monitor == true then term.redirect(display) end
        term.setCursorPos(1,5)
        term.setTextColor(colors.white)
        term.clear()

        term.setTextColor(currentColor)
        --print("Will you press the button?")
        drawBar()


        --Optional drawn things
        if (SHOW_LAST_PRESSER and lastPresser ~= "nil") then
            term.setTextColor(colors.white)
            print("\n")
            print("Last pressed by: ")
            term.setTextColor(lastPresserColor)
            print(lastPresser)
        end

        if(SHOW_TIMER) then
            --TODO: Make this
        end

        if (rs.getInput(BUTTON_SIDE)) then
            resetButton()
        end

        os.sleep(1)
    
    end
end


function killButton()
    local currentFile = shell.getRunningProgram()
    if DELETE_SELF then shell.run("delete "..currentFile) end
    shell.run("delete TheButtonBackup")

    term.clear()
    term.setTextColor(colors.red)
    print("\n")
    print("\n")
    error("The button has died.")
end

function resetButton()
    --local pressedTime = textutils.formatTime(os.time(), true)
    --if display_on_monitory == true then term.redirect(display) end --Not sure if neede
    term.clear()
    term.setTextColor(currentColor)
    
    
    lastPresserColor = currentColor
    lastPresser = detector.getPlayersInRange(10)[1]
    
    if SAVE_SCORES then addToScoreList(lastPresser, buttonValue) end --NEEDS TESTING!!!
    
    buttonValue = 0
    currentColor = possibleColors[1]
    
    --animation
    term.setCursorPos(8,5)
    textutils.slowWrite("BUTTON PRESSED!!", 14)
    

    term.setCursorPos(8,5)
    term.write("BUTTON PRESSED!!")
    sleep(0.7)
    term.clear()
    sleep(0.3)
    term.setCursorPos(8,5)
    term.write("BUTTON PRESSED!!")
    sleep(0.7)
    term.clear()
    sleep(0.3)
    term.setCursorPos(8,5)
    term.write("BUTTON PRESSED!!")

    os.sleep(2)
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
            term.write("[]")
        else
            term.setTextColor(colors.white)
            term.write("[]")
        end
    end
end

function saveState()
    --Things to be saved/loaded:loopCount, buttonValue, currentColor, lastPresser, lastPresserColor
    
    storedValues = {loopCount, buttonValue, currentColor, lastPresser, lastPresserColor}
    
    local h = fs.open("TheButtonBackup", "w")

    h.write(textutils.serialise(storedValues))
    h.close()
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
end

function addToScoreList(user, stage)
    --Save when a user pressed the button and what color/stage it was
    --UNTESTED!!!
    --Expected problems: Typos, writing occurs on last line of previous entry
    savedData = {"User: "..user,"Time: "..os.date("%Y/%m/%d - %H:%M:%S"),"Stage: "..stage}

    local h = fs.open("TheButtonScores", "a") --Open to edit without overwriting old file
    h.write(textutils.serialise(savedData))
    h.close()
end

function checkForPlayers(range)
    --Returns true if a player is within range (meters)
    --UNTESTED!!!
    if (detector.getPlayersInRange(range) ~= nil) then
        return true;
    else
        return false;
    end
end

waitForButton()