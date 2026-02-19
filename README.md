# ***station-location***
**This GitHub repository exists to store and back up scripts for my Roblox Studio project *Station Location*.**

## End-Product Summary
Station Location is an asymmetrical survival game that pits one Juggernaut player against up to eight Survivor players. The goal of the Juggernaut is to eliminate each Survivor while the Survivors have to work together to hinder or halt this process entirely. The game takes place in rounds, with intermissions in between to select the next map and Juggernaut based on certain criteria.

## Project Plan
The current plan for Station Location's developmental process will consist of the following:
1. **Stats and Rounds**
   + Create specific variables for each player for both in and out of rounds
     + Health - How much damage a player can take before they're eliminated
     + Stamina - How long a player can run for before needing to take a break
     + Malice - What determines if a player is the next Juggernaut
   + Make a timer system for rounds
     + Rounds are when the actual game takes place. The player with the most malice will be selected as Juggernaut and lose all of their malice
     + Between rounds intermissions will pop up, serving as a regrouping for players between rounds
2. **Survivors and Juggernauts**
   + Create Survivor and Juggernaut classes
     + Each class is equipped with their own unique abilities to enable unique playstyles and synergies
   + Design a functioning hitbox system for both players and their abilities
3. **Maps**
   + Create multiple maps for each round to take place


## Project Tools
<img width="150" height="150" alt="roblox-studio-logo-png_seeklogo-401838" src="https://github.com/user-attachments/assets/058e77bb-f8fa-4312-9ef8-65b354275d80" />
<img width="183" height="150" alt="image" src="https://github.com/user-attachments/assets/7b17670a-1e93-47e7-9e3d-0f401f30e560" />

ㅤ**Roblox Studio**ㅤㅤㅤㅤㅤㅤㅤ**Blender**ㅤ

**Roblox Studio** will be where the majority of the development of Station Location will take place. It provides both a Luau scripting service (Roblox Studio's modified Lua service) as well as a 3D workspace. **Blender** will be used to create complex 3D models that would otherwise be difficult/inefficient to make in Roblox Studio.
## Project Owner
I, Aidan Collis, am the sole creator of this project.

----

## Coding Contents/Folders
+ *Replicated Storage*
  + Here is where objects that do not exist within the main workspace but can be added in and cloned later by other scripts stay
  + Additionally, functions that are called by scripts are typically stored here
  + Will primarily feature scripts about specific 3D interactions
+ *ServerScriptService*
  + Here is where all server scripts can kept to run as the server is launched
  + Will primarily feature scripts discussing variables, server properties, and other miscellaneous interactions
+ *StarterGUI*
  + Here is where all 2D displays exist within that can be displayed on a player's screen
  + Will primarily feature local player sided scripts that display updated information retrieved from the server as well as sending information back to it with things such as button presses
+ *StarterPlayer*
  + Here is where scripts regarding players and their characters are kept
  + Will primarily feature niche scripts for changing character appearance as well as keybind changes
