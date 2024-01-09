
local component = require("component")
local modem = component.modem
local serialization = require("serialization")

if modem == nil then
    print("Modem component not found.")
    return
end

local function unserializeIfString(value)
    if type(value) == "string" then
        local success, result = pcall(serialization.unserialize, value)
        if success then
            return result
        else
            -- Handle deserialization error
            return value
        end
    else
        return value
    end
end

local event = require("event")
modem.open(listenPort)
local locs = {}
local searchLocs = true
modem.broadcast(listenPort, "ss"..pin)

while searchLocs do
    local type, _, from, port, _, response, name = event.pull()
    if type == "modem_message" then
        if (response == "loc" .. modem.address) then
            table.insert(locs, {
                name = name,
                id = #locs + 1,
                loc = from
            })
            print("recieved a loc with the name: " .. locs[#locs].name)
        end
    else
        if (type == "key_down") then
            if (port == 28) then
                print("Stopped listening for locs.")
                if (#locs == 0) then
                    print("No locs found.")
                    os.exit()
                end
                searchLocs = false
            end
        end
    end
end

local function executeCommand(id, command)
    modem.send(locs[id].loc, listenPort, "command", command)
    while true do
        local type, _, from, port, _, response, result1, result2, result3 = event.pull(10, "modem_message")
        if from == locs[id].loc then
            if response == "error" then
                return "error", result1
            elseif response == "result" then
                return "result", result1, result2, result3
            elseif type == nil then
                return "error", "No response from loc."
            end
        end
    end
end

while true do
    local type, _, from, port, _, message, command, id = event.pull("modem_message")
    if message == "connection create" then
        modem.send(from, listenPort, "connection created")
    elseif message == "command" then
        if (tonumber(id)) then
            local status, result1, result2, result3 = executeCommand(id, command)
            if status == "error" then
                modem.send(from, listenPort, "error", result1)
            else
                modem.send(from, listenPort, "result", result1, result2, result3)
            end
        else
            modem.send(from, listenPort, "error", "Invalid id/no id specified.")
        end
    elseif message == "getAllLocs" then
        modem.send(from, listenPort, "result", serialization.serialize(locs))
    end
end
