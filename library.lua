--Library updated 11/22/2020 7:47PM

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
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end
  