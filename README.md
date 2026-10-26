# U5


## About 🎃
Room 2. This is the second level of a game we are cooking up at school where all rooms are connected to a central server control room. Once the player finishes the first lvl/room the next room/level starts automatically. The other levels won't start unless the previous level is finished

## Controls 

* Move Left / Right | `A` / `D` or `Left` / `Right Arrows` 
* Move Up / Down | `W` / `S` or `Up` / `Down Arrows` 


## Built With 
* [Godot Engine](https://godotengine.org/) - Made with Godot 4.x

## How to Download and Play 
ps: you need to have git installed in order to download submodules. 

* **Windows:** Download the official installer from [git-scm.com/download/win](https://git-scm.com/download/win) and run the setup file.
* **macOS:** Open your Terminal and type `git --version`. If it's not installed, your Mac will automatically prompt you to install the developer tools.
* **Linux (Ubuntu/Debian):** Open your terminal and run:
  ```bash
  sudo apt update && sudo apt install git


First clone the repo 
```bash
#Paste this into your terminal in-order to download the files. 
git clone https://github.com/Halloween-prosjektet/rom-2.git
```
once the repo is cloned, go into the folder and paste these: 
```bash
# add the submodules and update them. 
git submodule add -b addon https://github.com/halloween-prosjektet/control-room.git addons/control_room_client
git submodule update --init addons/control_room_client
```
# IMPORTANT PS: MUST READ,

If you're only downloading this to play/test/contribute remember to turn off a line  `34`. This specific code here ```client.add_loading_screen()```
