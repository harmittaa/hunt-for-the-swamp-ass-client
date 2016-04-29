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


class DataController: NSObject {
    static let dataManagerSingleton:DataController = DataController()
    
    //MARK: try a fetch to see if a save game exists
    func doesSaveExist() -> Bool{
        do {
            let fetchRequest = NSFetchRequest(entityName: "HuntInProgress")
            let result:NSArray? = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            //print("[dataCtrl] result: \(result)")
            if let ress = result{
                if ress.count > 0{
                    if let gettedHunt = ress[0] as? HuntInProgress{
                        //print("[dataCtrl] found a hunt inside coredata \(gettedHunt)")
                        return true
                    }else{
                        //print("[dataCtrl] couldnt cast as huntinprog")
                        return false
                    }
                }
                else{
                    //print("[dataCtrl] array was empty in check for savegame")
                    return false
                }
            }
        } catch let error as NSError{
            //print(error)
            return false
        }
    }
    /*
     
     #
     #
     #  DONT TOUCH THESE METHODS!!!!!!!!!!!!!!!! THEY ARE VITAL TO CORE DATA FUNCTIONALITY!!!!!!!!!!!!!!!!!!
     #  ACTUAL USABLE METHODS ARE BELOW THESE!!!!!!!!!!!!!!!
     #
     #
     */
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "isodev.example.huntForTheSwampAss" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as! NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    /*
     #          actual methods
     #
     #
     #
     #
     #
     */
    
    
    
    //MARK: fetch object with a string
    func fetchObject(objectClassName: String)->[NSManagedObject]{
        //print("[datamanager] fetch method")
        let objectFetch = NSFetchRequest(entityName: objectClassName)
        let fetchedObjects: [NSManagedObject]
        do {
            fetchedObjects = try self.managedObjectContext.executeFetchRequest(objectFetch) as! [NSManagedObject]
        } catch {
            fatalError("\(error)")
        }
        //print("[DataManager] return value: \(fetchedObjects)")
        return fetchedObjects
    }
    
    //MARK: creates new core data hunt 🌚
    func createSaveHunt(huntToSave: HuntObject) -> HuntInProgress{
        let nsHuntInProgress = NSEntityDescription.insertNewObjectForEntityForName("HuntInProgress", inManagedObjectContext: self.managedObjectContext) as! HuntInProgress
        nsHuntInProgress.huntId = huntToSave.huntID
        var huntLocationProgress = 0
        for i in 0...huntToSave.locationList!.count-1{
            if huntToSave.locationList![i].isFound{
                huntLocationProgress += 1
            }
        }
        nsHuntInProgress.locationProgress = huntLocationProgress
        var clueProgress = 0
        for clue in huntToSave.locationList![huntLocationProgress].clueList {
            if !clue.lockedStatus {
                clueProgress += 1
                //print("[DataController] Saving Clue, getting the progress, current clue progress is \(clueProgress) for the clue \(clue.clueTitle)")
            }
        }
        nsHuntInProgress.clueProgress = clueProgress
        return nsHuntInProgress
    }
    
    // creates new core data for User
    func createUser(user: UserObject){
        let nsLoggedUser = NSEntityDescription.insertNewObjectForEntityForName("LoggedUser", inManagedObjectContext: self.managedObjectContext) as! LoggedUser
        nsLoggedUser.userId = user.userID
        nsLoggedUser.userName = user.userName
        nsLoggedUser.userDesc = user.userDesc
        print("[DataManager] New user object created into context")
    }

    
    //MARK: Save CoreData
    func saveCoreData(){
        //print("[datamanager] save method custom")
        do {
            try managedObjectContext.save()
        }catch{
            fatalError("Failed to save CoreData")
        }
    }
    
    //MARK: delete all
    func clearCoreData(){
        var result = fetchObject("HuntInProgress")
        for i in result{
            self.managedObjectContext.deleteObject(i as! HuntInProgress)
        }
        // save the empty core data to reflect that no game is in progress
        saveCoreData()
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        //print("[datamanager] save method")
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}