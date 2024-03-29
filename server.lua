local config = require("config")
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
modem.open(tonumber(config.port))
local locs = {}
local redstone = {}
local searchLocs = true
modem.broadcast(tonumber(config.port), "ss" .. config.pin or "")

while searchLocs do
    local type, _, from, port, _, response, name = event.pull()
    if type == "modem_message" then
        print(name)
        if (response == "loc" .. modem.address) then
            table.insert(locs, {
                name = name,
                id = #locs + 1,
                loc = from
            })
            print("recieved a loc with the name: " .. locs[#locs].name)
        elseif (response == "redstone") then
            table.insert(redstone, {
                name = name,
                id = #redstone + 1,
                address = from
            })
            print("recieved a redstone with the name: " .. redstone[#redstone].name)
        end
    else
        if (type == "key_down") then
            if (port == 28) then
                print("Stopped listening for locs.")
                if (#locs == 0 and #redstone == 0) then
                    print("No locs and redstone found.")
                    os.exit()
                end
                searchLocs = false
            end
        end
    end
end

local function executeCommand(id, command)
    if (locs[id] == nil) then
        return "error", "Loc not found."
    end
    modem.send(locs[id].loc, tonumber(config.port), "command", command)
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

local function executeRedstone(id, command)
    if (redstone[id] == nil) then
        return "error", "Redstone not found."
    end
    modem.send(redstone[id].address, tonumber(config.port), "setRedstone", command)
    print("sent redstone command")
    while true do
        local type, _, from, port, _, response, result = event.pull(10, "modem_message")
        print(response,result)
        if from == redstone[id].address then
            if response == "error" then
                return "error", result
            elseif response == "result" then
                return "result", result
            elseif type == nil then
                return "error", "No response from redstone."
            end
        end
    end
end

while true do
    local type, _, from, port, _, message, command, id = event.pull("modem_message")
    if message == "connection create" then
        modem.send(from, tonumber(config.port), "connection created")
    elseif message == "command" then
        if (tonumber(id)) then
            local status, result1, result2, result3 = executeCommand(id, command)
            if status == "error" then
                modem.send(from, tonumber(config.port), "error", result1)
            else
                modem.send(from, tonumber(config.port), "result", result1, result2, result3)
            end
        else
            modem.send(from, tonumber(config.port), "error", "Invalid id/no id specified.")
        end
    elseif message == "getAllLocs" then
        modem.send(from, tonumber(config.port), "result", serialization.serialize(locs))
    elseif message == "redstone" then
        print(message,command,id)
        if (tonumber(id)) then
            local status, result = executeRedstone(id, command)
            if status == "error" then
                modem.send(from, tonumber(config.port), "error", result)
            else
                modem.send(from, tonumber(config.port), "result", result)
            end
        else
            modem.send(from, tonumber(config.port), "error", "Invalid id/no id specified.")
        end
    end
end
