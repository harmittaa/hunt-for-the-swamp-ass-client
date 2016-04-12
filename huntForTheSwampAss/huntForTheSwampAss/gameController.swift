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
    
    var currentHunt: Hunt?
    var currentLocation: Location?
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
    }
    
    func setCurrentHunt(newHunt: Hunt){
        currentHunt = newHunt
    }
    
    func setCurrentLocation(newLocation: Location){
        currentLocation = newLocation
    }
    
    func getCurrentHunt() -> Hunt{
     return currentHunt!
     }
    
    func getCurrentLocation() -> Location{
        return currentLocation!
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
        self.currentHunt = array[0] as! Hunt
        print("[gameController] putintoMemory\(currentHunt!)")
        
    }
    
}
