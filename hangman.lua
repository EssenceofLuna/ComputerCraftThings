require '/ComputerCraftThings/library'

local validLetters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '} --Letters allowed in the game

print("Enter the phrase")
local phrase = read("*") --The phrase P1 enters

--Set game values to starting points
local phraseGuessed = false
local guessedLetters = {}

local phraseList = split(phrase, '%s') --Break phrase into list of characters

function checkIfValid(toCheck)
    -- --TODO: Fix this. Can't use 'in' in if statement
    -- --Checks if phrase is valid by comparing phraseList and validLetters
    -- for _, i in validLetters(toCheck) do
    --     --Executed if phraseList is valid
    --     print(table.concat(phraseList)) --debug
    --     --TODO: Write this. Possibly have main game loop in here
    --     return true
    -- end

    -- --Executed if phraseList is invalid
    -- print("Error: Invalid phrase")

    if(string.match(toCheck, "%w")) then
        print("Valid phrase")
        print(toCheck)
        
    else
        print("Invalid phrase. Phrase must be alphanumeric.")
    end
end

checkIfValid(phrase)

-- while phraseGuessed = false do
-- --Main game loop
--     print("Guess a letter!")
--     while 