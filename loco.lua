
local component = require("component")
local modem = component.modem
local serialization = require("serialization")
loco = component.ir_remote_control

if modem == nil then
    print("Modem component not found.")
    return
end

local commands = {
    ["info"] = true,
    ["consist"] = true,
    ["getTag"] = true,
    ["setTag"] = true,
    ["setThrottle"] = true,
    ["setReverser"] = true,
    ["getPos"] = true,
    ["setBrake"] = true,
    ["setTrainBrake"] = true,
    ["setIndependentBrake"] = true,
    ["horn"] = true,
    ["bell"] = true,
    ["getLinkUUID"] = true,
    ["getIgnition"] = true,
    ["setIgnition"] = true
}
local function serializeIfTable(value)
    if type(value) == "table" then
        return serialization.serialize(value)
    else
        return value
    end
end

function isStringInSet(str, set)
    local functionName = str:match("([^%(]+)")
    return set[functionName] ~= nil
end

local event = require("event")
local listenPort = 123
modem.open(listenPort)

while true do
    local _, _, from, port, _, message, command = event.pull("modem_message")
    if (message == "ss" .. pin) then
        modem.send(from, listenPort, "loc" .. from, name)
    elseif (message == "command") then
        if (not isStringInSet(command, commands)) then
            modem.send(from, listenPort, "error", "Command not found.")
        else
            local code = "local result1, result2, result3 = loco." .. command .. "\nreturn result1,result2,result3"
            local success, result1, result2, result3 = pcall(load(code))
            if success then
                result1 = serializeIfTable(result1) or "success"
                result2 = serializeIfTable(result2) or ""
                result3 = serializeIfTable(result3) or ""
                modem.send(from, listenPort, "result", result1, result2, result3)
            else
                modem.send(from, listenPort, "error", result1)
            end
        end
    end
end
