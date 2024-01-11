local fs = require("filesystem")
local component = require("component")
local internet = component.isAvailable("internet")
if (not internet) then
    print("No internet card found please insert one and try again.")
    return
end
local function promptUser(question)
    io.write(question)
    return io.read()
end
local config = {}

function write(file_path, content_to_add)
    local file, err = io.open(file_path, "r")
    if not file then
        print("Error opening file for reading: " .. err)
        return
    end

    -- Read existing content
    local existing_content = file:read("*a")
    file:close()

    file, err = io.open(file_path, "w")
    if not file then
        print("Error opening file for writing: " .. err)
        return
    end

    -- Write new content at the top
    file:write(content_to_add .. "\n")

    -- Write back the existing content
    file:write(existing_content)
    file:close()
end

-- Prompt the user for input
local function install()
    local selection = promptUser(
        "What software would you like to install? \n(1): loco.lua the loco controller,\n(2): server.lua the server?\n(3): redstone\n")
    if (selection == "1") then
        local pin = promptUser("Pincode: Leave empty for no pincode. ")
        local port = promptUser("Port: Leave empty for default port (900). ")
        if port == "" then
            port = "900"
        end
        local name = promptUser("Name: Leave empty for default name (loco). ")
        if name == "" then
            name = "loco"
        end
        print("Installing loco.lua")
        if not fs.exists("/home/loco") then
            os.execute("mkdir /home/loco")
        end
        local configExist = io.open("home/loco", "r")
        if configExist then
            configExist:close()
            config = require("loco")
        else
            config = {}
        end
        local file, err = io.open("/home/loco/config.lua", "w")
        if not file then
            error("Error opening file: " .. err)
        end
        file:write("return {\n    pin = \"" .. pin .. "\",\n    port = " .. port .. ",\n    name = \"" .. name ..
                       "\"\n}")
        file:close()
        os.execute(
            "wget -f https://raw.githubusercontent.com/Basgamer999/backend-train-control/main/loco.lua /home/loco/loco.lua")
    elseif (selection == "2") then
        local pin = promptUser("Pincode: Leave empty for no pincode. ")
        local port = promptUser("Port: Leave empty for default port (900). ")
        if port == "" then
            port = "900"
        end
        print("Installing server.lua")
        if not fs.exists("/home/server") then
            os.execute("mkdir /home/server")
        end
        local file, err = io.open("/home/server/config.lua", "w")
        if not file then
            error("Error opening file: " .. err)
        end
        file:write("return {\n    pin = \"" .. pin .. "\",\n    port = " .. port .. "\n}")
        file:close()
        os.execute(
            "wget -f https://raw.githubusercontent.com/Basgamer999/backend-train-control/main/server.lua /home/server/server.lua")
    elseif (selection == "3") then
        local pin = promptUser("Pincode: Leave empty for no pincode. ")
        local port = promptUser("Port: Leave empty for default port (900). ")
        local name = promptUser("Name: Leave empty for default name (redstone). ")
        local eeprom = promptUser("Do you want to run this program on a eeprom? (y/n) ")
        if eeprom == "y" then
            eeprom = true
        else
            eeprom = false
        end
        if name == "" then
            name = "redstone"
        end
        if port == "" then
            port = "900"
        end
        if (eeprom) then
            print("Installing redstone.lua on eeprom")
            os.execute(
                "wget -f https://raw.githubusercontent.com/Basgamer999/backend-train-control/main/redstone.lua /tmp/redstone.lua")
            write("/tmp/redstone.lua",
                "local name = \"" .. name .. "\"" .. "\nlocal port = " .. port .. "\nlocal pin = \"" .. pin .. "\"")
            os.execute("flash /tmp/redstone.lua "..name)
            os.execute("rm /tmp/redstone.lua")
        else
            print("Installing redstone.lua")
            if not fs.exists("/home/redstone") then
                os.execute("mkdir /home/redstone")
            end
            os.execute(
                "wget -f https://raw.githubusercontent.com/Basgamer999/backend-train-control/main/redstone.lua /home/redstone/redstone.lua")
            write("/home/redstone/redstone.lua",
                "local component = require(\"component\")\nlocal computer = require(\"computer\")\npin = \"" .. pin .. "\"\nport = " .. port .. "\nname = \"" .. name ..
                    "\"\n")
        end
    else
        print("Invalid selection.")
        install()
    end
end

install()
