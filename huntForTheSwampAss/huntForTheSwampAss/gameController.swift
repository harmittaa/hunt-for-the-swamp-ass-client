//
//  gameController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 11.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import CoreData

let gameControllerSingleton:GameController = GameController()

class GameController{
    
    var currentHunt: HuntObject?
    var currentLocation: LocationObject?
    var allGameModes: [GameModeObject]?
    var allHunts: [HuntObject]?
    //var dataManager:DataController
    
    
    private init(){
        /*print("[gameController Init] before dataManager init")
         dataManager = DataController.dataManagerSingleton
         print("[gameController Init] fetch request")
         var huntsList = dataManager.fetchObject("GameMode")
         huntsList = dataManager.fetchObject("GameMode")
         print("[gameController Init] count of objects in list of Hunts: \(huntsList.count)")
         if huntsList.count > 0{
         //currentHunt = huntsList[0] as! Hunt
         //print("[gameController Init] current Hunt: \(currentHunt)")
         }
         else {
         print("[gameController Init] no data found")
         
         }*/
        generatePlaceHolders()
    }
    
    func setCurrentHunt(newHunt: HuntObject){
        self.currentHunt = newHunt
    }
    
    func setCurrentLocation(newLocation: LocationObject){
        self.currentLocation = newLocation
    }
    
    func getCurrentHunt() -> HuntObject{
        return currentHunt!
    }
    
    func getCurrentLocation() -> LocationObject{
        return currentLocation!
    }
    func isAllLocationFound() -> Bool{
        if (currentHunt!.locationList[(currentHunt?.locationList.count)!-1].isFound){
            return true
        }
        else{
            return false
        }
    }
    
    func completeHunt(){
        currentHunt = nil
        currentLocation = nil
    }
    
    func putCurrentHuntIntoMemory(array: [NSManagedObject]){
        /*
         print("[gameController func] before dataManager init")
         //dataManager = DataController.dataManagerSingleton
         print("[gameController func] fetch request")
         var huntsList = dataManager.fetchObject("GameMode")
         huntsList = dataManager.fetchObject("GameMode")
         print("[gameController func] count of objects in list of Hunts: \(huntsList.count)")
         if huntsList.count > 0{
         //currentHunt = huntsList[0] as! Hunt
         //print("[gameController Init] current Hunt: \(currentHunt)")
         }
         else {
         print("[gameController func] no data found")
         
         }
         */
        //let tempHunt = array[0] as! Hunt
        //self.currentHunt = HuntObject(title: tempHunt.huntTitle!, desc: tempHunt.huntDescription!)
        
    }
    
    func generatePlaceHolders(){
        let testLocation = LocationObject(title: "place #1", beacon: BeaconObject(beaconmajor: 148, beaconminor: 148, beaconuuid: "00000000-0000-0000-0000-000000000000"))
        let testLocation2 = LocationObject(title: "place #2", beacon: BeaconObject(beaconmajor: 96, beaconminor: 96, beaconuuid: "00000000-0000-0000-0000-000000000000"))
        let testLocation3 = LocationObject(title: "place #3", beacon: BeaconObject(beaconmajor: 66, beaconminor: 66, beaconuuid: "00000000-0000-0000-0000-000000000000"))
        allHunts = [HuntObject(title: "hunt 1", desc: "this is a hunt placeholder #1", locations: [testLocation,testLocation2,testLocation3]),HuntObject(title: "hunt 2", desc: "this is a hunt placeholder #2", locations: [testLocation,testLocation2,testLocation3]),HuntObject(title: "hunt 3", desc: "this is a hunt placeholder #3", locations: [testLocation,testLocation2,testLocation3])]
        
        allGameModes = [GameModeObject(gameDesc: "This is a GameMode #1", gameTitle: "GameMode 1", huntsInGame: allHunts!),GameModeObject(gameDesc: "This is a GameMode #2", gameTitle: "GameMode 2", huntsInGame: allHunts!),GameModeObject(gameDesc: "This is a GameMode #3", gameTitle: "GameMode 3", huntsInGame: allHunts!)]
        
    }
    
    
}
