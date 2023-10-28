--FormUtils--
--[[
API for formatting text and inputing with buttons
Internal Functions:
throwError("string")

Functions:
centerText("string")
centerX()
centerY()
setWrite("string",{x,y})
setColors(colors.x,colors.x)
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
Purpose: Centers text on line
Input: String
Output: Nil
Usage: Enter text and it will be centered. If screen is odd will align to left by 1.
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
	term.write(str)
  end
end

--[[
Purpose: Centers cursor on a column
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
Purpose: Centers cursor on the center row
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
Purpose: To write at a set of coords
Input: String, {x,y, boolean}
Output: Nil
Usage: 
Input a string
Input coords (optional) and it will write there. If no value for x or y it will default to current coords.
Input Boolean (optional) will advance to the next line at the same starting point as previous. 
Use nil as a value to ignore coord input if using boolean a.
]]--
function setWrite(s,x,y,a)
	local oldx,oldy = term.getCursorPos()
	local x = x or oldx
	local y = y or oldy
	local a = a or false
	
	term.setCursorPos(x,y)
	term.write(s)
	x = x + string.len(s)
	
	if a == true then
		x = x - string.len(s)
		y = y + 1
		term.setCursorPos(x,y)
	else
	term.setCursorPos(x,y)
	end
end

--[[
Purpose: To change both colors at once.
Input: colors.x, colors.x/2
output: Nil
Usage: Used to change both text color and background color at the same time.
]]--
function setColors(c1,c2)
	local c1 = c1 or term.getTextColor()
	local c2 = c2 or term.getBackgroundColor()
	term.setTextColor(c1)
	term.setBackgroundColor(c2)
end