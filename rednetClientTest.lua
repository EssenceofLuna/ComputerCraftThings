require '/ComputerCraftThings/APIs/library'
rednet.open('back')
print("Starting Rednet test a Client")
id,message = rednet.receive()
rednet.broadcast('Hello PC '..id..'! You said: '..message)
rednet.close()
print("Rednet closed")