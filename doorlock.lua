require '/ComputerCraftThings/APIs/library'

--Unfinished Project--

function initialSetup()
    --TODO: Get input on where the door is
    --TODO: Get password (store locally?)
end

function getCommand()
    --Get input from user for what to do
    --This function loops until valid command is entered

    --TODO: Loop until valid command is entered
    term.clear()
    print("Enter Command")
    local inputStr = input()
    if inputStr == "lock" then
        return "lock"
    elseif inputStr == "unlock" then
        return "unlock"
    elseif inputStr == "changepassword" then
        return "changepassword"
    else
        return "error"
    end
end

--TODO: Fix server startup stuff