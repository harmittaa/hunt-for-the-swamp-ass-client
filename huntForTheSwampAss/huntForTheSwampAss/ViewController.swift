//
//  ViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 5.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, ViewObserverProtocol {

    @IBOutlet weak var teamButton: UIButton!
    
    //let 🌚:DataController = DataController.dataManagerSingleton
    let beaconFinder:BeaconFinder = beaconFinderSingleton
    let gameController = gameControllerSingleton
    var isDisplayingPopup = false
    @IBAction func testButton(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[ViewController] init values of GC: \(gameController.currentHunt)")
        self.navigationItem.hidesBackButton = true
        //create a datacontroller, otherwise it wont init the values for use in other controllers, use moonface for maximum effect
        beaconFinder.startScanningBeacon()
        // Do any additional setup after loading the view, typically from a nib.
        /*let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Hunt")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            var queryResult = results as! [NSManagedObject]
            print("got a result \(queryResult)")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }*/
        
        //MARK: core data shenanigans
        /*let gm1 = 🌚.createNewGameMode("Test1GameMode", gameModeDesc: "Test1 Game Mode Description")
        let hunt1 = 🌚.createNewHunt("Test1Hunt", huntDesc: "testi yksi huntti jee")
        gm1.setValue([hunt1] as NSSet, forKeyPath: "hunt")
        let hunttttt = gm1.hunt?.allObjects[0] as! Hunt
        hunttttt.huntTitle = "This is a custom title"
        print(gm1)
        print(gm1.hunt?.allObjects[0])
        🌚.saveCoreData()
        */
        //loadStuff(🌚)
        registerAsObserver()
 
    }
    
    /*func loadStuff(dataM: DataController){
        print("[ViewController] fetch request")
        let b = dataM.fetchObject("Hunt")
        gameController.putCurrentHuntIntoMemory(b)
    }*/
    
    //MARK: Obeserver functions
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    func receiveNotification() {
        if(!isDisplayingPopup){
            isDisplayingPopup = true
            let noAuthAlert = UIAlertController.init(title: gameController.currentLocation!.locationTitle, message: "Found a thing", preferredStyle: .Alert)
            print("[ViewController] received notification as observer")
            //custom action with a segue
            
            let settingsAction = UIAlertAction(title: "Continue", style: .Default, handler: { (testAction) -> Void in
                self.performSegueWithIdentifier("LocationDiscoveredSegue", sender: self)
                self.gameController.currentLocation!.isFound = true
            })
            // add actions to the alert
            noAuthAlert.addAction(settingsAction)
            //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.presentViewController(noAuthAlert, animated: true, completion: nil)
            //})
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    @IBAction func gameButtonAction(sender: UIButton) {
        var segueId: String
        if let z = gameController.currentHunt{
            segueId = "MainMenuToGameScreen"
        }
        else{
            segueId = "MainMenuToGameModes"
        }
        performSegueWithIdentifier(segueId, sender: self)
    }

}

