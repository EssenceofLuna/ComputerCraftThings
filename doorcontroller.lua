isDoorOpen = nil


function startup()
    --TODO: Function should check if door is open and set isDoorOpen accordingly
    --either check using redstone or check from user
end

function openDoor()
    --Function to open door
    --Send redstone signal
end

function closeDoor()
end

redstone.setOutput('left', true)
sleep(5)
redstone.setOutput('left', false)