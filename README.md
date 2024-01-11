# backend-train-control
Control multiple trains and switched or other redstone interfaces.

# How to install?

For the server:
Step 1. Setup a computer with at least a network card and a internet card.
Step 2. Run `wget https://raw.githubusercontent.com/Basgamer999/backend-train-control/main/installer.lua && installer.lua` in the console.
Step 3. Follow the installer for what you want to setup.
Step 4. Run the program every program will be put in his own folder under home. For server this is /home/server for locomotive controller this is /home/loco. 
Step 5. Make sure your loco and redstone clients are running before you start the server then press enter when all locomotives and redstone controllers showed up.
For the api:
Step 1. Setup a computer with at least a network card and a internet card.
Step 2. Run `wget https://raw.githubusercontent.com/Basgamer999/backend-train-control/main/api.lua`
Step 3. Require the libary in your code: local api = require("api")

# How does the api work? 
You can view every function in the wiki

# FAQ
Q: Does the redstone reciever work on a microcontroller? 
A: Yes Its written specifically for the microcontroller. Make sure to use the installer and select eeprom and not directly flash to the eeprom as the code has a few other stuff on the OS version compare to the eeprom version.

Q: Can the computers run headless?
A: Yes no computer requires a screen attached to work.
