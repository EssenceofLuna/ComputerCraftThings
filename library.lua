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

function keyPress() --raid.keyPress(keys.{key})
    local event, p1 = os.pullEvent("key")
    return p1
end

function center(str,y)
    if y == nil then
        y = 1
    end
    local length = term.getSize()
    local x = string.len(str)
    local even,total
    if x > length then
      print("invalid length")
    else 
      even = (length - x) % 2
      total = ((length - x) - even) / 2
      term.setCursorPos(total,y)
      term.write(str)
    end
end