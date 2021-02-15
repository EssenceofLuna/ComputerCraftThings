require '/ComputerCraftThings/APIs/library'

--SETTINGS
--Amount of time in seconds to pulse redstone.
PULSE_LENGTH = 0.1
--Amount of time in seconds between allowing inputs.
OPENING_LENGTH = 3
--Which side of the computer the program should send the signals
REDSTONE_SIDE = 'left'
--Which side of the computer the rednet thing is on
REDNET_SIDE = 'top'
--(Unused) What protocal to use in rednet
REDNET_PROTOCOL = 'vaultdoor'
--Table of CC IDs that are allowed to be used
ALLOWED_IDS = {'6'}
--(Unused) Set to true to allow any rednet signal
ALLOW_ANY_ID = false
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

-- function waitForRednet()
--     term.clear()
--     print("Waiting for rednet...")
--     message = rednet.receive()
--     return message
-- end

initialSetup()

while true do
    --DEBUG CODE
    --print(rednet.receive())
    messageID, message = rednet.receive('vaultdoor')
    print("ID: "..messageID)
    print("Message: "..message)
    if has_value(ALLOWED_IDS, messageID) == true then
        if message == "actuatedoor" then
            actuateDoor()
        end
    end
    --print("Distance: "..messageDistance)
end