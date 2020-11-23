require '/ComputerCraftThings/library'

local validLetters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '} --Letters allowed in the game

print("Enter the phrase")
local phrase = read("*") --The phrase P1 enters

--Set game values to starting points
local phraseGuessed = false
local guessedLetters = {}

--TODO: Lua doesn't have a split function. Find a way to break string into a table to its characters
local phraseList = split(phrase, '%s') --Break phrase into list of characters
print(table.concat(phraseList))

-- while phraseGuessed = false do
-- --     Main game loop
--     print("Guess a letter!")