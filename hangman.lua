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

function checkLetter(set, letter)
    --function to check if a letter is in a list
    for i,v in ipairs(set) do
        if v == letter then
            return true
        end
    end
    return false
end

function runGame(phrase)
    if phrase == nil then
        --If no phrase entered, ask for one
        phrase = askForPhrase()
    end

    phrase = string.upper(phrase) --make phrase uppercase
    --TODO: Ask user how many guesses to give the guesser
    local maxGuesses = 8

    local phraseLength = string.len(phrase)
    local phraseList = split(phrase, "%s")

    local guessedLetters = {}

    local guessCount = 0

    while true do
        --main game loop
        term.clear()

        if tableLength(guessedLetters) > 0 then
            --if letters have been guessed, print the letters that have been guessed
            print("Guessed letters: "..table.concat(guessedLetters, ', '))
        end

        print("Guess a letter")
        local letter = io.read()
        letter = string.upper(letter)

        --Currently broken: checkLetter() always returns false
        if checkLetter(guessedLetters, letter) then
            --letter has already been guessed
            print("You have already guessed that letter!")
            sleep(3)
        else
            --letter has not been poreviously guessed
            if string.len(letter) == 1 then
                --string is 1 character long
                if checkIfValid(letter) then                   
                    --Letter was valid
                    --Add the letter to the guessed letters, then sort alphabetically
                    table.insert(guessedLetters, letter)
                    table.sort(guessedLetters)

                    term.clear()
                    
                    --print("Guessed letters: "..table.concat(guessedLetters, ', ')) --Debug
                    if checkLetter(phraseList, letter) then
                        --Letter was in word
                        print(letter.." is in the word!")
                    else
                        --Letter was not in word
                        print(letter.." is incorrect")
                        guessCount = guessCount+1

                        if guessCount >= maxGuess then
                            --TODO: This break might break the code idk
                            print("Game Over!")
                            break
                        end
                    end

                    --TODO: Turn "Press key to continue" into a function, maybe add to library.lua
                    print("Press any key to continue")
                    os.pullEvent("key")
                else
                    --letter was invalid
                    term.clear()
                    print("Error: Not a valid letter")
                    print("Press any key to continue")
                    os.pullEvent("key")
                end
            else
                --letter was longer than 1 character
                term.clear()
                print("Error: Letter can only be 1 character long")
                print("Press any key to continue")
                    os.pullEvent("key")
            end
        end
    end
end

runGame()