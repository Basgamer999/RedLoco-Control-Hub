--A very basic script to showcase how to set the throttle and brake of a train
-- This script pulls the input from the user and then sets the throlle or brake.

local api = require("api")
api.connect(900)
-- Function to process the entered number
function processNumber(number)
    if number >= 0 and number <= 1 then
        -- Add your logic here to do something with the entered number
        print("Received number: " .. number)
        api.setBrake(1,0)
        api.setThrottle(1,number)
    elseif number >= -1 and number < 0 then
        api.setThrottle(1,0)
        api.setBrake(1,math.abs(number))
    else
        print("Invalid input. Please enter a number between -1 and 1.")
    end
end

-- Main function to listen for input and call the processNumber function
function main()
    while true do
        io.write("Enter a number between -1 and 1: ")
        local input = io.read()

        -- Check if the input is a valid number
        local number = tonumber(input)
        if number then
            processNumber(number)
        else
            print("Invalid input. Please enter a valid number.")
        end
    end
end

-- Run the main function
main()
local api = require("api")
api.connect(900)

api.setRedstone(1,0)
api.setRedstone(2,0)
api.setRedstone(3,0)
api.setRedstone(4,0)