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
function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

--Returns true it table contains item
function tableContains (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
  
  --Returns the type of computer as a table
function os.getComputerType()
    local ret = {}

    if term.isColor() then
        table.insert(ret, "advaned")
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