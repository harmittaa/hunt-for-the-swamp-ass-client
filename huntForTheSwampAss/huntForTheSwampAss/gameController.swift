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
    var playerPoints: Int
    var huntStartDate: NSDate?
    var currentUser: UserObject?
    
    private init(){
        /*//print("[gameController Init] before dataManager init")
         dataManager = DataController.dataManagerSingleton
         //print("[gameController Init] fetch request")
         var huntsList = dataManager.fetchObject("GameMode")
         huntsList = dataManager.fetchObject("GameMode")
         //print("[gameController Init] count of objects in list of Hunts: \(huntsList.count)")
         if huntsList.count > 0{
         //currentHunt = huntsList[0] as! Hunt
         ////print("[gameController Init] current Hunt: \(currentHunt)")
         }
         else {
         //print("[gameController Init] no data found")
         
         }*/
        //generatePlaceHolders()
        allHunts = [HuntObject]()
        playerPoints = 0
    }
    
    func setUser(user: UserObject) {
        self.currentUser = user
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
    
    //MARK: create core data object
    func updateSavedHunt(){
        let testFetch = DataController.dataManagerSingleton.fetchObject("HuntInProgress") as! [NSManagedObject]
        if testFetch.count > 0{
            //print("[gamectrl] there is a game in progress")

            /*let gottedHunt = testFetch[0] as! HuntInProgress
             //print("[gamectrl] \(gottedHunt.huntId) \(gottedHunt.locationProgress)")
             gottedHunt.setValue(gameControllerSingleton.currentHunt!.huntID, forKey: "huntId")
             gottedHunt.setValue(0, forKey: "locationProgress")
             DataController.dataManagerSingleton.saveCoreData()*/
        }
        else{
            //print("[gamectrl] no game in progress creating new one now")
            DataController.dataManagerSingleton.createSaveHunt(self.currentHunt!)
            DataController.dataManagerSingleton.saveCoreData()
        }
        ////print("[gamectrl] current status of game: \((testFetch[0] as! HuntInProgress).locationProgress)")
    }
    
    //change the values of the hunt in core data to reflect the current hunt that is in progress
    func updateSavedHuntFromCurrentHunt(){
        //print("[GameController] Updating the state of the hunt to the CoreData")
        let testFetch = DataController.dataManagerSingleton.fetchObject("HuntInProgress")
        let huntToChange = testFetch[0] as! HuntInProgress
        huntToChange.huntId = self.currentHunt!.huntID
        huntToChange.locationProgress = self.getCurrentHuntLocationProgress()
        huntToChange.clueProgress = self.getCurrentClueProgress()
        huntToChange.startDate = self.huntStartDate
        DataController.dataManagerSingleton.saveCoreData()
    }
    
    //get the hunt from core data and set the current hunt of gamectrl as the corresponding HuntObject
    func loadCurrentHuntFromCoreData(){
        var testFetch = DataController.dataManagerSingleton.fetchObject("HuntInProgress")
        let coreHunt = testFetch[0] as! HuntInProgress
        self.currentHunt = self.getHuntById(coreHunt.huntId as! Int)
        self.currentLocation = currentHunt!.locationList![coreHunt.locationProgress as! Int]
        self.huntStartDate = coreHunt.startDate
        //print("[GameController] There are \(coreHunt.clueProgress) clues unlocked!")
        for i in 0..<Int(coreHunt.clueProgress!) {
            //print("[GameController] Unlocking clue \(currentLocation?.clueList[i].clueTitle)")
            //print("[GameController] Clue list size \(currentLocation?.clueList.count)")
            currentLocation?.clueList[i].lockedStatus = false
        }
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
    
    func getCurrentClueProgress() -> Int{
        var clueProgress = 0
        for clue in (currentLocation?.clueList)! {
            if !clue.lockedStatus {
                clueProgress += 1
                //print("[GameController] Saving Clue, getting the progress, current clue progress is \(clueProgress) for the clue \(clue.clueTitle)")
            }
        }
        return clueProgress
    }
    
    //points functions
    //set initial starting value for points with formula hunt.locations.coiunt x 100
    func pointsInitForNewHunt(){
        self.playerPoints = 0//self.playerPoints = self.currentHunt!.locationList!.count*100
        self.huntStartDate = NSDate()
        print("[gamectrl] new hunt started: starting points for this game \(self.playerPoints)")
    }
    
    func pointsUpdateTotalPoints(pointsToAdd: Int){
        self.playerPoints += pointsToAdd
    }
    //compare start time and end time of hunt and calculate points accoriding to percentage of 24hours
    func pointsCalculateTimePointsForFinishedHunt() -> Double{
        var currentTime = NSDate()
        var timeDifference = currentTime.timeIntervalSinceDate(self.huntStartDate!)
        var timePoints:Double = 0
        print("[gamectrl] timeDifference \(10/timeDifference)")
        if timeDifference <= 86400{
            let percentOf24 = timeDifference / 86400
            var maxTimePointsForHunt = Double(self.currentHunt!.locationList!.count*50)
            timePoints = (maxTimePointsForHunt-maxTimePointsForHunt*percentOf24)
            return floor(timePoints)
        }else{
            return floor(timePoints)
        }
    }
    //calculate points for a single location, deductions come from unlocking clues
    func pointsCalculateForFinishedLocation() -> Int{
        var returnPoints:Int = 0
        for i in self.currentLocation!.clueList{
            if i.lockedStatus{
                if i.clueTier == 1{
                returnPoints += 30
                }else if i.clueTier == 2{
                    returnPoints += 70
                }
            }
        }
        return returnPoints
    }

}
