term.clear()
print("Select a game")
print("*=Advanced Computer Required")


--TODO: Make print strings and game commands a table to be able to easily add new games
print("1) *Doom [Instal Required]") --6BcdRV75
print("2) *LDRIS (Tetris)") --https://github.com/LDDestroier/CC/raw/master/ldris.lua
print("3) *CClickers") --zCfqpZfy
print("4) *TerrariCCa") --MR9kuYV9
local selection = io.read()

term.clear()

if selection == "1" then
    shell.run("pastebin run 6BcdRV75")
elseif selection == "2" then
    shell.run("wget run https://github.com/LDDestroier/CC/raw/master/ldris.lua")
elseif selection == "3" then
    shell.run("pastebin run zCfqpZfy")
elseif selection == "4" then
    shell.run("pastebin run MR9kuYV9")
else
    print("Error: Invalid selection")
end