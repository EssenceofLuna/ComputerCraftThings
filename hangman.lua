require '/ComputerCraftThings/library'

local validLetters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '} --Letters allowed in the game
local validLettersPhrase

print("Enter the phrase")
local phrase = read("*") --The phrase P1 enters

--Set game values to starting points
local phraseGuessed = false
local guessedLetters = {}

function checkIfValid(toCheck)

    --OLD CODE
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
    --END OLD CODE


    --if(string.gmatch(toCheck, "%a")) then
    if(toCheck:match("%A")) then
        --Invalid phrase
        --print("Invalid phrase. Phrase must be alphanumeric.") --Debug
        return false
    else
        --Valid phrase
        --print("Valid phrase") --debug
        --print(toCheck) --debug

        return true
    end
end

--checkIfValid(phrase) --debug
if checkIfValid(phrase) then
    print(phrase)
elseif checkIfValid(phrase) == false then
    print("Invalid phrase. Phrase must only be letters and spaces.")
else
    print("An error occurred while checking if your phrase was valid.")
end

-- while phraseGuessed = false do
-- --Main game loop
--     print("Guess a letter!")
--     while 