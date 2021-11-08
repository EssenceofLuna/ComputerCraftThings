--SETTINGS

--The side the computer expects a redstone signal for the button
--"left" "right" "front" "back" "top" or "bottom" for valid sides
BUTTON_SIDE = "right"
MONITOR_SIDE = "top"

--Whether or not to display a timer
DISPLAY_TIMER = true
--Amount of time (in seconds) for each segment of the timer
--Multiply by 10 to get time until the button dies
TIMER_PER_SEGMENT = 60

display = peripheral.wrap(MONITOR_SIDE)

