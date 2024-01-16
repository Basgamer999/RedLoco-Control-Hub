local component = require("component")
local gpu = component.gpu
local event = require("event")
local api = require("api")
api.connect(900)

local buttons = {{
    id = 1,
    x = 5,
    y = 2,
    width = 3,
    height = 2,
    value = "Throttle"
}, {
    id = 1,
    x = 5,
    y = 23,
    width = 3,
    height = 2,
    value = "Brake"
}, {
    id = 1,
    x = 2,
    y = 2,
    width = 3,
    height = 4,
    value = "Forward"
}, {
    id = 1,
    x = 2,
    y = 20,
    width = 3,
    height = 4,
    value = "Backward"
}, {
    id = 1,
    x = 2,
    y = 13,
    width = 3,
    height = 1,
    value = "Neutral"
}, {
    id = 2,
    x = 13,
    y = 2,
    width = 3,
    height = 2,
    value = "Throttle"
}, {
    id = 2,
    x = 13,
    y = 23,
    width = 3,
    height = 2,
    value = "Brake"
}, {
    id = 2,
    x = 10,
    y = 2,
    width = 3,
    height = 4,
    value = "Forward"
}, {
    id = 2,
    x = 10,
    y = 20,
    width = 3,
    height = 4,
    value = "Backward"
}, {
    id = 2,
    x = 10,
    y = 13,
    width = 3,
    height = 1,
    value = "Neutral"
}, {
    id = 3,
    x = 21,
    y = 2,
    width = 3,
    height = 2,
    value = "Throttle"
}, {
    id = 3,
    x = 21,
    y = 23,
    width = 3,
    height = 2,
    value = "Brake"
}, {
    id = 3,
    x = 18,
    y = 2,
    width = 3,
    height = 4,
    value = "Forward"
}, {
    id = 3,
    x = 18,
    y = 20,
    width = 3,
    height = 4,
    value = "Backward"
}, {
    id = 3,
    x = 18,
    y = 13,
    width = 3,
    height = 1,
    value = "Neutral"
}, {
    id = 4,
    x = 29,
    y = 2,
    width = 3,
    height = 2,
    value = "Throttle"
}, {
    id = 4,
    x = 29,
    y = 23,
    width = 3,
    height = 2,
    value = "Brake"
}, {
    id = 4,
    x = 26,
    y = 2,
    width = 3,
    height = 4,
    value = "Forward"
}, {
    id = 4,
    x = 26,
    y = 20,
    width = 3,
    height = 4,
    value = "Backward"
}, {
    id = 4,
    x = 26,
    y = 13,
    width = 3,
    height = 1,
    value = "Neutral"
}, {
    id = 1,
    x = 42,
    y = 3,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 1,
    x = 44,
    y = 5,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 2,
    x = 50,
    y = 3,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 2,
    x = 52,
    y = 5,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 3,
    x = 58,
    y = 3,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 3,
    x = 60,
    y = 5,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 4,
    x = 66,
    y = 3,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 4,
    x = 68,
    y = 5,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 5,
    x = 74,
    y = 3,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 5,
    x = 76,
    y = 5,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 6,
    x = 42,
    y = 14,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 6,
    x = 44,
    y = 16,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 7,
    x = 50,
    y = 14,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 7,
    x = 52,
    y = 16,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 8,
    x = 58,
    y = 14,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 8,
    x = 60,
    y = 16,
    width = 2,
    height = 2,
}, {
    id = 9,
    x = 66,
    y = 14,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 9,
    x = 68,
    y = 16,
    width = 2,
    height = 2,
    value = "SwitchOn"
}, {
    id = 10,
    x = 74,
    y = 14,
    width = 2,
    height = 2,
    value = "SwitchOff"
}, {
    id = 10,
    x = 76,
    y = 16,
    width = 2,
    height = 2,
    value = "SwitchOn"
}}

local trains = {{
    id = 1,
    x = 2,
    y = 2,
    currentThrottle = 0,
    reverser = 0
}, {
    id = 2,
    x = 10,
    y = 2,
    currentThrottle = 0,
    reverser = 0
}, {
    id = 3,
    x = 18,
    y = 2,
    currentThrottle = 0,
    reverser = 0
}, {
    id = 4,
    x = 26,
    y = 2,
    currentThrottle = 0,
    reverser = 0
}}

local switches = {{
    id = 1,
    x = 42,
    y = 3,
    state = 0
}, {
    id = 2,
    x = 50,
    y = 3,
    state = 0
}, {
    id = 3,
    x = 58,
    y = 3,
    state = 0
}, {
    id = 4,
    x = 66,
    y = 3,
    state = 0
}, {
    id = 5,
    x = 74,
    y = 3,
    state = 0
}, {
    id = 6,
    x = 42,
    y = 14,
    state = 0
}, {
    id = 7,
    x = 50,
    y = 14,
    state = 0
}, {
    id = 8,
    x = 58,
    y = 14,
    state = 0
}, {
    id = 9,
    x = 66,
    y = 14,
    state = 0
}, {
    id = 10,
    x = 74,
    y = 14,
    state = 0
}}

local width, height = gpu.getResolution()
local trainBuffer = gpu.allocateBuffer(6, 23)
local switchBuffer = gpu.allocateBuffer(4, 7)

local function editTrain(id)
    local buf = gpu.allocateBuffer(6, 23)
    gpu.setActiveBuffer(buf)
    gpu.bitblt(buf, 1, 1, 6, 23, trainBuffer)
    gpu.setBackground(0xF7E26B) -- yellow
    local y = math.floor(trains[id].currentThrottle * 8)
    gpu.fill(4, (12 - y), 3, 1, " ")
    if (trains[id].reverser == 1) then
        gpu.fill(2, 1, 1, 4, " ")
        gpu.fill(1, 2, 3, 1, " ")
    elseif (trains[id].reverser == -1) then
        gpu.fill(2, 20, 1, 4, " ")
        gpu.fill(1, 22, 3, 1, " ")
    else
        gpu.fill(1, 12, 3, 1, " ")
    end
    gpu.bitblt(0, trains[id].x, trains[id].y, 6, 23, buf)
    gpu.freeBuffer(buf)
end

local function editSwitch(id)
    local buf = gpu.allocateBuffer(4, 7)
    gpu.setActiveBuffer(buf)
    gpu.bitblt(buf, 1, 1, 4, 7, switchBuffer)
    gpu.setBackground(0x22B14C) -- Green
    if (switches[id].state == 0) then
        gpu.fill(1, 1, 2, 2, " ")
    else
        gpu.fill(3, 3, 2, 2, " ")
    end
    gpu.bitblt(0, switches[id].x, switches[id].y, 4, 7, buf)
    gpu.freeBuffer(buf)
end

local function handleButtonClick(x, y)
    for _, button in ipairs(buttons) do
        if x >= button.x and x <= button.x + button.width - 1 and y >= button.y and y <= button.y + button.height - 1 then
            if button.value == "Throttle" then
                if (trains[button.id].currentThrottle == 1) then
                    break
                end
                trains[button.id].currentThrottle = trains[button.id].currentThrottle + 1 / 8
                if (trains[button.id].currentThrottle > 0) then
                    api.setThrottle(button.id, trains[button.id].currentThrottle)
                elseif (trains[button.id].currentThrottle < 0) then
                    api.setBrake(button.id, math.abs(trains[button.id].currentThrottle))
                elseif (trains[button.id].currentThrottle == 0) then
                    api.setThrottle(button.id, 0)
                    api.setBrake(button.id, 0)
                end
                editTrain(button.id)
            elseif button.value == "Brake" then
                if (trains[button.id].currentThrottle == -1) then
                    break
                end
                trains[button.id].currentThrottle = trains[button.id].currentThrottle - 1 / 8
                if (trains[button.id].currentThrottle > 0) then
                    api.setThrottle(button.id, trains[button.id].currentThrottle)
                elseif (trains[button.id].currentThrottle < 0) then
                    api.setBrake(button.id, math.abs(trains[button.id].currentThrottle))
                elseif (trains[button.id].currentThrottle == 0) then
                    api.setThrottle(button.id, 0)
                    api.setBrake(button.id, 0)
                end
                editTrain(button.id)
            elseif button.value == "Forward" then
                trains[button.id].reverser = 1
                api.setReverser(button.id, 1)
                editTrain(button.id)
            elseif button.value == "Backward" then
                trains[button.id].reverser = -1
                api.setReverser(button.id, -1)
                editTrain(button.id)
            elseif button.value == "Neutral" then
                trains[button.id].reverser = 0
                api.setReverser(button.id, 0)
                editTrain(button.id)
            elseif button.value == "SwitchOn" then
                switches[button.id].state = 1
                api.setRedstone(button.id, 15)
                editSwitch(button.id)
            elseif button.value == "SwitchOff" then
                switches[button.id].state = 0
                api.setRedstone(button.id, 0)
                editSwitch(button.id)
            end
            gpu.setActiveBuffer(0)
            break -- Exit the loop once a button is found
        end
    end
end

gpu.setActiveBuffer(trainBuffer)
-- buffer for locomotives
gpu.setBackground(0x22B14C) -- green
gpu.fill(4, 1, 3, 2, " ")
gpu.setBackground(0xED1C24) -- red
gpu.fill(4, 22, 3, 2, " ")
gpu.setBackground(0xC3C3C3) -- grey
gpu.fill(4, 4, 3, 17, " ")
gpu.setBackground(0xFFFFFF) -- white
gpu.fill(5, 4, 1, 17, " ")
gpu.fill(2, 1, 1, 4, " ")
gpu.fill(1, 2, 3, 1, " ")
gpu.fill(2, 20, 1, 4, " ")
gpu.fill(1, 22, 3, 1, " ")
gpu.fill(1, 12, 3, 1, " ")

-- buffer for switches
gpu.setActiveBuffer(switchBuffer)
gpu.setBackground(0xC3C3C3)
gpu.fill(1, 1, 2, 2, " ")
gpu.fill(3, 3, 2, 2, " ")
gpu.setBackground(0xFFFFFF)
gpu.fill(1, 3, 2, 4, " ")
-- screen filling
gpu.setActiveBuffer(0)
gpu.fill(1, 1, width, height, " ")
gpu.setBackground(0xffffff)
gpu.fill(36, 1, 4, height, " ")
editTrain(1)
editTrain(2)
editTrain(3)
editTrain(4)
gpu.setBackground(0x000000)
editSwitch(1)
editSwitch(2)
editSwitch(3)
editSwitch(4)
editSwitch(5)
editSwitch(6)
editSwitch(7)
editSwitch(8)
editSwitch(9)
editSwitch(10)

while true do
    local _, _, x, y = event.pull("touch")
    handleButtonClick(x, y)
end
