require '/ComputerCraftThings/library'

local validLetters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '} --Letters allowed in the game

print("Enter the phrase")
local phrase = read("*") --The phrase P1 enters

--Set game values to starting points
local phraseGuessed = false
local guessedLetters = {}

local phraseList = split(phrase, '%s') --Break phrase into list of characters

--TODO: Fix this. Can't use 'in' in if statement
if phraseList in validLetters then
    print(table.concat(phraseList))
else
    print("Error: Invalid phrase")
end

while phraseGuessed = false do
--     Main game loop
    print("Guess a letter!")
    while 