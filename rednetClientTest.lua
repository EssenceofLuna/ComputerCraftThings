require '/ComputerCraftThings/APIs/library'

term.clear()
rednet.open('back')
print("Starting Rednet test a Client")
while true do
    term.clear()
    print("Waiting for message...")
    id,message = rednet.receive()
    if id ~= nil then
        print("Message Recieved! Responding")
        rednet.broadcast('Hello PC '..id..'! You said: '..message)
    end
end
rednet.close()
print("Rednet closed")