--SETTINGS

--The side the computer expects a redstone signal for the button
--"left" "right" "front" "back" "top" or "bottom" for valid sides
BUTTON_SIDE = "right"
MONITOR_SIDE = "top"

--Whether or not to display a timer
DISPLAY_TIMER = true
--Amount of time (in seconds) for each segment of the timer
--Multiply by 12 to get time until the button dies
TIME_PER_SEGMENT = 60

display = peripheral.wrap(MONITOR_SIDE)

loopCount = 0

for loopCount=1,12 do
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
    term.write(currentColor)

    os.sleep(1)
end