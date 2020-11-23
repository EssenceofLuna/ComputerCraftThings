term.clear()
print("Select a game")
print("*=Advanced Computer Required")


print("1) *Doom") --6BcdRV75
print("2) *LDRIS (Tetris)") --https://github.com/LDDestroier/CC/raw/master/ldris.lua
local selection = io.read()

term.clear()

if selection == "1" then
    shell.run("pastebin run 6BcdRV75")
elseif selection == "2" then
    shell.run("wget run https://github.com/LDDestroier/CC/raw/master/ldris.lua")
else
    print("Error: Invalid selection")
end