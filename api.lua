local event = require("event")
local serialization = require("serialization")
local component = require("component")

local modem = component.modem

local function unserializeIfString(value)
    if type(value) == "string" then
        local success, result = pcall(serialization.unserialize, value)
        if success and result ~= nil then
            return result
        else
            return value
        end
    else
        return value
    end
end

local api = {}
local instance = {}

local function waitResponse()
    while true do
        local type, _, from, port, _, response, result1, result2, result3 = event.pull(10, "modem_message")
        if from == instance.id then
            if response == "error" then
                return false, result1
            elseif response == "result" then
                return true, unserializeIfString(result1) or "", unserializeIfString(result2) or "",
                    unserializeIfString(result3) or ""
            end
        end
    end
end

api.connect = function(port, id)
    modem.open(port)
    if (id == nil) then
        modem.broadcast(port, "connection create")
        while true do
            local type, _, from, port, _, response = event.pull(10, "modem_message")
            if (response == "connection created") then
                id = from
                break
            elseif (response == nil) then
                return false, "No server replied to the connection request.	"
            end
        end
    end
    instance.id = id
    instance.port = port
    return true, id
end

api.getAllLocs = function()
    modem.send(instance.id, instance.port, "getAllLocs")
    return waitResponse()
end

api.info = function(id)
    modem.send(instance.id, instance.port, "command", "info()", id)
    return waitResponse()
end

api.consist = function(id)
    modem.send(instance.id, instance.port, "command", "consist()", id)
    return waitResponse()
end

api.getTag = function(id)
    modem.send(instance.id, instance.port, "command", "getTag()", id)
    return waitResponse()
end

api.setTag = function(id, tag)
    modem.send(instance.id, instance.port, "command", "setTag('" .. tag .. "')", id)
    return waitResponse()
end

api.setThrottle = function(id, value)
    modem.send(instance.id, instance.port, "command", "setThrottle(" .. value .. ")", id)
    return waitResponse()
end

api.setReverser = function(id, value)
    modem.send(instance.id, instance.port, "command", "setReverser(" .. value .. ")", id)
    return waitResponse()
end

api.info = function(id)
    modem.send(instance.id, instance.port, "command", "getPos()", id)
    return waitResponse()
end

api.setBrake = function(id, value)
    modem.send(instance.id, instance.port, "command", "setBrake(" .. value .. ")", id)
    return waitResponse()
end

api.setTrainBrake = function(id, value)
    modem.send(instance.id, instance.port, "command", "setTrainBrake(" .. value .. ")", id)
    return waitResponse()
end

api.setIndependentBrake = function(id, value)
    modem.send(instance.id, instance.port, "command", "setIndependentBrake(" .. value .. ")", id)
    return waitResponse()
end

api.horn = function(id)
    modem.send(instance.id, instance.port, "command", "horn()", id)
    return waitResponse()
end

api.bell = function(id)
    modem.send(instance.id, instance.port, "command", "bell()", id)
    return waitResponse()
end

api.getLinkUUID = function(id)
    modem.send(instance.id, instance.port, "command", "getLinkUUID()", id)
    return waitResponse()
end

api.getIgnition = function(id)
    modem.send(instance.id, instance.port, "command", "getIgnition()", id)
    return waitResponse()
end

api.setIgnition = function(id, value)
    modem.send(instance.id, instance.port, "command", "setIgnition(" .. tostring(value) .. ")", id)
    return waitResponse()
end

api.setRedstone = function(id, value)
    modem.send(instance.id, instance.port, "redstone", tostring(value), id)
    return waitResponse()
end

return api
