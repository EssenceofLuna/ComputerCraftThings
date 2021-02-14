--SETTINGS
--Amount of time in seconds to pulse redstone.
PULSE_LENGTH = 0.1
--Amount of time in seconds between allowing inputs.
OPENING_LENGTH = 3
--Which side of the computer the program should send the signals
REDSTONE_SIDE = 'left'
--Which side of the computer the rednet thing is on
REDNET_SIDE = 'top'
--Secret message to get the door to open. Not very secure but w/e
DOOR_MESSAGE = 'actuate door'
ALLOWED_COMPUTERS = {''}
--END SETTINGS

function initialSetup()
    --Setup rednet and stuff
    rednet.open(REDNET_SIDE)
end

function actuateDoor()
    print("Actuating door...")
    redstone.setOutput(REDSTONE_SIDE, true)
    sleep(PULSE_LENGTH)
    redstone.setOutput(REDSTONE_SIDE, false)
    sleep(OPENING_LENGTH)
    term.clear()
end

function waitForRednet()
    term.clear()
    print("Waiting for rednet...")
    message = rednet.receive()
    return message
end

initialSetup()

while true do
    --DEBUG CODE
    print(waitForRednet())
end