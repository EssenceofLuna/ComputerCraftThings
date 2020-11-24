require '/ComputerCraftThings/library'

--TODO: Make this into a function

--Set game values to starting points
--These are currently unused and will probably be deleted in the future
local phraseGuessed = false
local guessedLetters = {}

function checkIfValid(toCheck)
    --Function to check if toCheck contains anything other than letters.
    if(toCheck:match("%A")) then
        --TODO: Change to allow spaces
        --Failed: Contains other than letters
        return false
    else
        --Passed: Only contains letters
        return true
    end
end

function askForPhrase()
    -- function that asks for and returns a phrase
    while true do
        --Loop that goes until a valid phrase is entered
        print("Enter the phrase")
        local phrase = read("*") --The phrase P1 enters

        if checkIfValid(phrase) == true then
            --Phrase was valid. Return phrase
            return phrase
            --break
        else
            --Phrase was not valid. Clear and keep asking for phrases.
            term.clear()
            print("Invalid phrase. Phrase may only contain letters.")
        end
    end
end   

--DEBUG

phrase = askForPhrase()


if checkIfValid(phrase) == true then
    print("Valid phrase:")
    print(phrase)
elseif checkIfValid(phrase) == false then
    print("Invalid phrase. Phrase may only contain letters.")
else
    print("An error occurred while checking if your phrase was valid.")
end

--TODO: Write main game loop
-- while phraseGuessed = false do
-- --Main game loop
--     print("Guess a letter!")
--     while 