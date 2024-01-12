--Redstone computer
local redstone = component.proxy(component.list("redstone")())
local modem = component.proxy(component.list("modem")())
modem.open(port)

while true do
    local type, _, from, port, _, message, status = computer.pullSignal()
    if type == "modem_message" then
        if (message == "ss"..pin) then 
            modem.send(from, tonumber(port), "redstone", name)
        elseif message == "setRedstone" then
            redstone.setOutput(1, tonumber(status))
            modem.send(from, tonumber(port), "result", "sucess")
        end
    end
end
