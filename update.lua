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

if (#arg == 0) then
    --If no argument provided, discover the type of computer and update accordingly
    if os.getComputerType == 'computer' or 'advanced_computer' then
        updateComputer()
    elseif os.getComputerType == 'turtle' or 'advanced_turtle' then
        updateTurtle()
    elseif os.getComputerType == 'pda' or 'advanced_pda' then
        updatePDA()
    else
        print("Error updating. Computer not updated.")
    end
else
    --Update based on argument provided by user
    if arg[1] == 'computer' or 'advanced_computer' then
        updateComputer()
    elseif arg[1] == 'turtle' or 'advanced_turtle' then
        updateTurtle()
    elseif arg[1] == 'pda' or 'advanced_pda' then
        updatePDA()
    else
        print("Error updating: Invalid computer type provided.")
        print("Please enter computer, turtle, of pda (all lowercase")
        print("Or enter no argument to auto update.")
    end
end
