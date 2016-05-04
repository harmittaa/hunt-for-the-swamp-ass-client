Hunt for the Swamp Ass
====
###### by Matti Mäki-Kihniä & Daniel Zakharin

Hunt for the Swamp Ass a treasure hunt style application for iOS.
The application can be used with all iOS devices that support Bluetooth LE.
In Hunt for the Swamp Ass users try to find predefined locations based on clues provided for them.
At each location there is a hidden beacon, which sends out a broadcast, that the users’ device can pick up.
Once the user's device picks up the signal, the application marks that location as visited and gives the user a clue for the next location.

Each Hunt has multiple hunt locations which the user needs to discover in order to complete the hunt.
Once a user finishes a hunt, they are given points based on the amount of time they’ve spent on the hunt and the amount of clues they've unlocked.

The code for the Restful API, that is used to fetch information from the back end, can be found [here](https://github.com/harmittaa/hunt-for-swamp-ass-API).

###### Features
* Logging in
* Checking login data from the server
* Logging out
* Creating a user
* Registering to server
* Saving a the current user to CoreData
* Choose game mode
* Game modes are fetched from the server
* Choose hunt
* Hunts are fetched from the server
* Unlock clues
* Clues are fetched from the server
* Points based on unlocked clues
* Score is saved on the server
* Clues with map or image
* Clues that drop a marker on the game map
* Unlocking clues in correct order
* Finding location
* Getting information about the location that was found
* Saving hunt, hunt status and score to CoreData
* Saving clue status to CoreData
* Navigating between hunt and menu
* Quitting a hunt
* Finishing a hunt
* Leaderboards for top users
* Data is fetched from the server
* Leaderboards for each hunt
* Data is fetched from the server

###### Screenshots

![alt text](https://github.com/harmittaa/hunt-for-the-swamp-ass-client/blob/master/images/screenshots.jpg?raw=true "Main menu")