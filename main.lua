-- Title: NumericTextFields
-- Name: Chelsea NF
-- Course: ICS2O/3C
-- This program displays a math question and asks the user to answer in a numeric 
-- textfield terminal.

---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 100/255, 0/255, 255/255)

--------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local numericField 
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer
local incorrectObject
local randomOperator

---------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number
	randomNumber1 = math.random(-5, 20)
	randomNumber2 = math.random(-5, 20)

	correctAnswer = randomNumber1 + randomNumber2

-- create question in text object
	questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

end

local function HideCorrect()
	correctObject.isVisible = false 
	AskQuestion() 

end


------------------------------------------------------
 local function NumericFieldListener( event )

 	-- User begins editing "numericField"
 	if ( event.phase == "began" ) then

 		-- clear text field
 		event.target.text = ""

 	elseif event.phase == "submitted" then

 		-- when the answer is submitted (enter key is pressed) set user input to user's answer
 		userAnswer = tonumber (event.target.text)

 		-- if the users answer and the correct answer are the same:
 		if (userAnswer == correctAnswer) then
 			correctObject.isVisible = true
 			timer.performWithDelay(2000, HideCorrect)

 			-- if the users answer and the incorrect answer are the same:
 			if (userAnswer == incorrectAnswer) then
 				incorrectObject.isVisible = true
 				timer.performWithDelay(2000, HideIncorrect)
 			end
 		end
 	end
 end

---------------------------------------------------------------------
-- OBJECT CREATION
---------------------------------------------------------------------

-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(255/255, 255/255, 0/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(255/255, 250/255, 0/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(155/255, 42/255, 198/255)

incorrectObject.isVisible = false

-- Create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80 )
numericField.inputType =  "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-------------------------------------------------------------------
-- FUNCTION CALLS
------------------------------------------------------------------

-- call the funtion to ask the question
AskQuestion()