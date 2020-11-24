require '/ComputerCraftThings/library'

--TODO: Make this into a function

--Set game values to starting points
local phraseGuessed = false
local guessedLetters = {}

function checkIfValid(toCheck)
    if(toCheck:match("%A")) then
        --TODO: Change to allow spaces
        
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

function askForPhrase()
    while true do
        -- function that asks for and returns a phrase
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

-- while phraseGuessed = false do
-- --Main game loop
--     print("Guess a letter!")
--     while 