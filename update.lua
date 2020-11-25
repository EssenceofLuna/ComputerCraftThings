-- require '/ComputerCraftThings/library' --Removed to make update.lua seperate from all other scripts.

--Instal Github: 'pastebin run p8PJVxC4'        https://github.com/eric-wieser/computercraft-github
--Initial install: 'wget run https://raw.githubusercontent.com/Alstro20/ComputerCraftThings/master/update.lua'

--Checks if github is installed
if fs.exists("github") and fs.exists("github.rom") then
    --Do nothing
else
    --github installation process

    print("Warning: Github not found. Github is required to use this script")
    print("Press any key to install github, or hold CTRL+T to cancel.")
    sleep(2)
    os.pullEvent("key")

    --download and instal github
    shell.run("pastebin run p8PJVxC4")
    term.clear()
end

--Returns the type of computer as a string
function os.getComputerType()
    local ret = {}

    if term.isColor() then
        table.insert(ret, "advanced")
    end
    if pocket then
        table.insert(ret, "pda")
    elseif turtle then
        table.insert(ret, "turtle")
    else
        table.insert(ret, "computer")
    end
    return table.concat(ret, "_")
end

--Functions to update different computer types
function updateComputer()
    --https://github.com/Alstro20/ComputerCraftThings/tree/master
    shell.run("github clone Alstro20/ComputerCraftThings")
    term.clear()
    print("Computer Updated!")
end

function updateTurtle()
    --https://github.com/Alstro20/ComputerCraftThings/tree/turtles
    shell.run("github clone Alstro20/ComputerCraftThings -b turtles")
    term.clear()
    print("Turtle Updated!")
end

function updatePDA()
    shell.run("github clone Alstro20/ComputerCraftThings")
    term.clear()
    
    --TODO: Create a branch for PDA's
    print("PDA's are not yet supported. Downloaded default computer branch.")
    print("PDA Updated!")
end

term.clear()
print("Updating from github")

--Store the computer's type as a string
computerType = os.getComputerType()

if (#arg == 0) then
    --If no argument provided, discover the type of computer and update accordingly
    if computerType == 'computer' or computerType == 'advanced_computer' then
        updateComputer()
    elseif computerType == 'turtle' or computerType == 'advanced_turtle' then
        updateTurtle()
    elseif computerType == 'pda' or computerType == 'advanced_pda' then
        updatePDA()
    else
        print("Error updating. Invalid computer type detected. Computer not updated.")
        print("Computer type "..computerType.." detected")
    end
elseif (#arg == 1) then
    argument = table.concat(arg)

    --Update based on argument provided by user
    if argument == 'computer' or argument == 'advanced_computer' then
        updateComputer()
    elseif argument == 'turtle' or argument == 'advanced_turtle' then
        updateTurtle()
    elseif argument == 'pda' or argument == 'advanced_pda' then
        updatePDA()
    else
        print("Error updating: Invalid computer type provided by user.")
        print("Please enter computer, turtle, of pda (all lowercase")
        print("Or enter no argument to auto update.")
    end
else
    --Could not determing PC type. Asking user directly.
    print("Error: Invalid PC Type. Please enter PC type:")
    print("0) cancel")
    print("1) Computer (default)")
    print("2) Turtle")
    print("3) PDA")

    local continueInput = io.read()
    if continueInput == 1 then
        updateComputer()
    elseif continueInput == 2 then
        updateTurtle()
    elseif continueInput == 3 then
        updatePDA()
    else
        --PC type not entered/Invalid entered. Canceling
        print("Canceling...")
        sleep(3)
        term.clear()
        --NOTE: This should be the end of the code
    end
end