--FormUtils--
--[[
API for formatting text and inputing with buttons

Internal Functions:
throwError("string")

Functions:
keyPress(keys.x)
centerText("string")
centerX()
centerY()
setWrite("string",{x,y})
advance(boolean,boolean)
]]--


--[[
Purpose: Internal Function For Errors
Input: String
Output: Nil
Usage: Creates a bright message informing the user that theres a problem.
]]--
local function throwError(str)
	term.clear()
	term.setCursorPos(1,1)
	term.setTextColor(colors.gray)
	term.setBackgroundColor(colors.orange)
	term.clearLine()
	centerText(str)
	term.setTextColor(colors.white)
	term.setBackgroundColor(colors.black)
	return
end

--[[
Purpose: To detect a key press
Input: keys.var
Output: boolean
Usage: use in a while loop. break on success. use multiple in a while for diffrent inputs.
]]--
function keyPress(val) 
  local timer = os.startTimer(0.05)
  local event, p1 = os.pullEvent()
  if event == "key" then
	if p1 == val then
		return true
	end
  elseif event == "timer" then
	return false
  end
end

--[[
Purpose: Centers text on line
Input: String
Output: Nil
Usage: Enter text and it will be centered. If screen is odd will align to left by 1
]]--
function centerText(str)
  local oldx, oldy = term.getCursorPos()
  local x,y = term.getSize()
  local length = string.len(str)
  local even
  if length > x then
	throwError("String Length Exceeds Screen Size!")
  else 
    even = (x - length) % 2
    x = ((x - length) - even) / 2
    term.setCursorPos(x,oldy)
    print(str)
  end
end

--[[
Purpose: Centers cursor on a line 
Input: Nil
Output: Nil
Usage: Sets cursor in center of x value. If screen is even will align to the left by 1
]]--
function centerX()
  local x,y = term.getSize()
  local oldx, oldy = term.getCursorPos()
  local even = x % 2

  if even > 0 then
    x = x - 1
  end
  
  term.setCursorPos(x/2,oldy)
end


--[[
Purpose: Centers cursor on a column
Input: Nil
Output: Nil
Usage: Sets cursor in center of y value. If screen is even will be aligned up by 1
]]--
function centerY()
  local x,y = term.getSize()
  local oldx, oldy = term.getCursorPos()
  local even = y % 2

  if even > 0 then
    y = y - 1
  end
  
  term.setCursorPos(oldx,y/2)
end

--[[
Purpose: To write a set of coords
Input: String, {x,y}
Output: Nil
Usage: Input a string, and coords (optional) and it will write there. If no value for x or y it will default to current coords.
]]--
function setWrite(s,x,y)
	local oldx,oldy = term.getCursorPos()
	local x = x or oldx
	local y = y or oldy
	term.setCursorPos(x,y)
	term.write(s)
end

--[[
Purpose: To advance the cursor to the next line or space
Input: {boolean(x), boolean(y)}
Output: Nil
Usage: If x = true then it will advance on x line. If y = true it will advance on y. Will default to only increasing y.
]]--
function advance(x,y)
	local x = x or false
	local y = x or true
	local oldx, oldy = term.getCursorPos()
	if x == true then
		oldx = oldx + 1
	end
	
	if y == true then
		oldy = oldy + 1
	end
	
	if x == false and y == false then
		throwError("This isn't doing anything")
		return
	end 
	
	term.setCursorPos(oldx, oldy)
  end
