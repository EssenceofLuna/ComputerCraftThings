require '/ComputerCraftThings/APIs/formUtils'

function whitneyIsABitch(loopAmount)
    for i=1,loopAmount do
        print("Whitney is a bitch")
    end
end

--Split string into characters
function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end

    local t={}
    
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

--Returns the number of elements in a table as an int
--I think doing #<table> returns the same thing idk maybe this entire function is useless lol
function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
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

--[[
Purpose: Add a line to a log file on the computer
Input: string, string, bool
Output: Nil. TODO: true if success, false if failed to write
Usage:
    Input a file directory and a string to be added.
    Input a string to be added at the bottom of the file on a new line.
    (Optional) Set timestamp to true to add a timestamp at the start of the string.
]]--
function addToLog(file, string, timestamp)
    if timestamp == nil then timestamp = false end --set timestamp to false if timestamp isn't included.

    --Add line break to end of string
    string = string..'\n'
    if timestamp == true then string = os.date("%d.%m.%Y %H:%M:%S")..string end --Add timestamp to start of string if requested.

    --Get file in append mode
    local file = io.open(file, "a")
    io.output(file) --Set output as file path to overwrite when finished
    io.write(string)
    io.close(file)
end


--[[
Purpose: Get the contents of a log file
Input: string
Output: String containing everything in the log
Usage: Input the file path to a log, and the contents of the log will be returned.
Using textutils' pagedPrint() is recommended so the entire log can be read as the user wants.
]]
function getLog(file)
    --Open the file in read mode
    local file = io.open(file, "r")
    io.input(file)

    --Save the contents to a string
    local logContents = io.read("*all")

    --Close the file and return the contents
    io.close(file)
    return logContents
end