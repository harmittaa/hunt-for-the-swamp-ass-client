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
    var allHunts: [HuntObject]
    var selectedGameMode: GameModeObject?
    var splashScreen: SplashScreenViewController?
    //var dataManager:DataController =
    
    
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
        //generatePlaceHolders()
        allHunts = [HuntObject]()
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
        if (currentHunt!.locationList![(currentHunt?.locationList!.count)!-1].isFound){
            return true
        }
        else{
            return false
        }
    }
    //MARK: completion of hunt
    func completeHunt(){
        currentHunt?.resetAllLocations()
        currentHunt = nil
        currentLocation = nil
        DataController.dataManagerSingleton.clearCoreData()
    }
    
    //MARK: create core adata object
    func updateSavedHunt(){
        let testFetch = DataController.dataManagerSingleton.fetchObject("HuntInProgress") as! [NSManagedObject]
        if testFetch.count > 0{
            print("[gamectrl] there is a game in progress")
            /*let gottedHunt = testFetch[0] as! HuntInProgress
             print("[gamectrl] \(gottedHunt.huntId) \(gottedHunt.locationProgress)")
             gottedHunt.setValue(gameControllerSingleton.currentHunt!.huntID, forKey: "huntId")
             gottedHunt.setValue(0, forKey: "locationProgress")
             DataController.dataManagerSingleton.saveCoreData()*/
        }
        else{
            print("[gamectrl] no game in progress creating new one now")
            DataController.dataManagerSingleton.createSaveHunt(self.currentHunt!)
            DataController.dataManagerSingleton.saveCoreData()
        }
        //print("[gamectrl] current status of game: \((testFetch[0] as! HuntInProgress).locationProgress)")
    }
    
    //chenge the values of the hunt in core data to reflect the current hunt that is in progress
    func updateSavedHuntFromCurrentHunt(){
        let testFetch = DataController.dataManagerSingleton.fetchObject("HuntInProgress")
        let huntToChange = testFetch[0] as! HuntInProgress
        huntToChange.huntId = self.currentHunt!.huntID
        huntToChange.locationProgress = self.getCurrentHuntLocationProgress()
        DataController.dataManagerSingleton.saveCoreData()
    }
    //get the hunt from core data and set the current hunt of gamectrl as the corresponding HuntObject
    func loadCurrentHuntFromCoreData(){
        var testFetch = DataController.dataManagerSingleton.fetchObject("HuntInProgress")
        let coreHunt = testFetch[0] as! HuntInProgress
        self.currentHunt = self.getHuntById(coreHunt.huntId as! Int)
        self.currentLocation = currentHunt!.locationList![coreHunt.locationProgress as! Int]
        self.setLocationFoundStatusForHuntWithProgress(self.currentHunt!, progress: coreHunt.locationProgress as! Int)
    }
    
    //get a hunt from all hunts with an id
    func getHuntById(id:Int) -> HuntObject?{
        var returnHunt:HuntObject?
        for i in self.allHunts{
            if i.huntID == id{
                returnHunt = i
            }
        }
        return returnHunt
    }
    
    //get through the location list and mark them either found or not
    func setLocationFoundStatusForHuntWithProgress(hunt: HuntObject, progress: Int){
        if(progress > 0){
            for i in 0...progress-1{
                hunt.locationList![i].isFound = true
            }
        }
    }
    
    func getCurrentHuntLocationProgress() -> Int{
        var returnValue = 0
        for i in 0...((self.currentHunt?.locationList!.count)!-1){
            if self.currentHunt!.locationList![i].isFound{
                returnValue += 1
            }
        }
        return returnValue
    }
    
}
