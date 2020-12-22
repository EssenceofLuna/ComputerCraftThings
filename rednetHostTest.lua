require '/ComputerCraftThings/APIs/library'
rednet.open('back')
print("Starting Rednet test as Host")
rednet.broadcast('Host PC Broadcast')
id,message = rednet.receive()
print('Message recieved from PC '..id)
print(message)
rednet.close()
print("Rednet closed")