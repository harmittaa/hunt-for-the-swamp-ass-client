//
//  DataManager.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let dataManagerSingleton:DataController = DataController()

class DataController: NSObject {
    var managedObjectContext: NSManagedObjectContext
    
     override private init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
        
        
    }
    //MARK: CreateGameMode 🌚
    func createNewGameMode(gameModeTitle: String, gameModeDesc:String?)-> GameMode{
        let gameMode = NSEntityDescription.insertNewObjectForEntityForName("GameMode", inManagedObjectContext: self.managedObjectContext) as! GameMode
        gameMode.gameModeTitle = gameModeTitle
        gameMode.gameModeDescription = gameModeDesc ?? ""
        /*let set = gameMode.hunt!
        let hunts = set.allObjects as? [Hunt]*/
        return gameMode
    }
    
    
    //MARK: CreateHunt
    func createNewHunt(huntTitle: String,huntDesc:String?)-> Hunt{
        let huntteri = NSEntityDescription.insertNewObjectForEntityForName("Hunt", inManagedObjectContext: self.managedObjectContext) as! Hunt
        huntteri.huntDescription = huntTitle
        huntteri.huntTitle = huntDesc ?? ""
        return huntteri
    }
    
    //MARK: CreateLocation
    func createLocation(locationTitle: String)-> Location{
        let location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: self.managedObjectContext) as! Location
        location.locationTitle = locationTitle
        return location
    }
    
    //MARK: CreateClue
    /*func createMapClue(clueTier: Int, clueDesc: String) -> MapClue{
        let clue = NSEntityDescription.insertNewObjectForEntityForName("Clue", inManagedObjectContext: self.managedObjectContext) as! Clue
        clue. = clueTier
        clue.clueDescription = clueDesc
        return clue
    }
    //MARK: ImageClue
    func createImageClue(clueTier: Int, clueDesc: String) -> Clue{
        let clue = NSEntityDescription.insertNewObjectForEntityForName("Clue", inManagedObjectContext: self.managedObjectContext) as! Clue
        clue.clueTier = clueTier
        clue.clueDescription = clueDesc
        return clue
    }
    */
    //MARK: fetchObject
    func fetchObject(objectClassName: String)->[NSManagedObject]{
        let objectFetch = NSFetchRequest(entityName: objectClassName)
        let fetchedObjects: [NSManagedObject]
        do {
            fetchedObjects = try self.managedObjectContext.executeFetchRequest(objectFetch) as! [NSManagedObject]
        } catch {
            fatalError("\(error)")
        }
        return fetchedObjects
    }
    //MARK: Save CoreData
    func saveCoreData(){
        do {
            try managedObjectContext.save()
        }catch{
            fatalError("Failed to save CoreData")
        }
    }

}