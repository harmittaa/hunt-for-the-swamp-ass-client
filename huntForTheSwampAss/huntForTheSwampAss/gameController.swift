//
//  gameController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 11.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

let gameControllerSingleton:GameController = GameController()

class GameController{
    
    var currentHunt: Hunt?
    var currentLocation: Location?
    let dataManager:DataController
    
    
    private init(){
        print("before gamcontroller init")
        dataManager = DataController.dataManagerSingleton
        print("count of objects: \(dataManager.fetchObject("Hunt").count)")
        if dataManager.fetchObject("Hunt").count > 0{
            let allHunts = dataManager.fetchObject("Hunt") as! [Hunt]
            currentHunt = allHunts[0]
            print("current Hunt: \(currentHunt)")
        }
        else {
            print("no data found")
            
        }
    }
    
    func setCurrentHunt(newHunt: Hunt){
        currentHunt = newHunt
    }
    
    func setCurrentLocation(newLocation: Location){
        currentLocation = newLocation
    }
    
    /*func getCurrentHunt() -> Hunt{
     return currentHunt
     }*/
    
    func getCurrentLocation() -> Location{
        return currentLocation!
    }
    
    func fetchCurrentHuntIntoMemory(){
        
        
    }
    
}
