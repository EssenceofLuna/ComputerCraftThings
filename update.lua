require '/ComputerCraftThings/library'

--Functions to update different computer types
--
function updateComputer()
    --https://github.com/Alstro20/ComputerCraftThings/tree/master
    shell.run("github clone Alstro20/ComputerCraftThings")
    term.clear()
    print("Computer Updated!")
end

function updateTurtle()
    --https://github.com/Alstro20/ComputerCraftThings/tree/turtles
    shell.run("github clone Alstro20/ComputerCraftThings -b")
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
    print("DEBUG: Args were 0") --Debug
    sleep(3) --Debug

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
    print("DEBUG: Args were 1") --Debug
    argument = table.concat(arg)
    print(argument)
    sleep(3) --Debug

    --Update based on argument provided by user
    if argument == 'computer' or argument == 'advanced_computer' then
        print("DEBUG: computer argument") --Debug
        sleep(3) --Debug
        updateComputer()
    elseif argument == 'turtle' or argument == 'advanced_turtle' then
        print("DEBUG: Turtle argument") --Debug
        sleep(3) --Debug
        updateTurtle()
    elseif argument == 'pda' or argument == 'advanced_pda' then
        print("DEBUG: PDA argument") --Debug
        sleep(3) --Debug
        updatePDA()
    else
        print("Error updating: Invalid computer type provided by user.")
        print("Please enter computer, turtle, of pda (all lowercase")
        print("Or enter no argument to auto update.")
    end
else
    print("Error: Too many arguments provided")
end