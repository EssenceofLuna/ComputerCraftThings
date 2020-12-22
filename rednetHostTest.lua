require '/ComputerCraftThings/APIs/library'

term.clear()
rednet.open('back')
print("Starting Rednet test as Host")
print("Enter a message...")
rednet.broadcast(io.read())
while true do
    term.clear()
    print("Waiting for message...")
    id,message = rednet.receive()
    if id ~= nil then
        print('Message recieved from PC '..id)
        print(message)
        break
    end
end
rednet.close()
print("Rednet closed")