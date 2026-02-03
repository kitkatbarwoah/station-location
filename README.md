# station-location
----
**This GitHub repository exists to store and back up scripts for my Roblox Studio project Station Location.**

Station Location is an asymmetrical survival game that pits one Juggernaut player against up to eight Survivor players. The goal of the Juggernaut is to eliminate each Survivor while the Survivors have to work together to hinder or halt this process entirely. The game takes place in rounds, with intermissions in between to select the next map and Juggernaut based on certain criteria.

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
