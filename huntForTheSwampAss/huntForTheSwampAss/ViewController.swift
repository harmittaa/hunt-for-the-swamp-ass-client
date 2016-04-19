//
//  ViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 5.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.


// Daniel: isodev.example.huntForTheSwampAss
// matti: fi.metropolia.huntForTheSwampAss

import UIKit
import CoreData

class ViewController: UIViewController, ViewObserverProtocol {

    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var quitHuntButton: UIButton!
    
    //let 🌚:DataController = DataController.dataManagerSingleton
    let beaconFinder:BeaconFinder = beaconFinderSingleton
    let gameController = gameControllerSingleton
    let httpController = httpRequestControllerSingleton
    var isDisplayingPopup = false
    @IBAction func testButton(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[ViewController] init values of GC: \(gameController.currentHunt)")
        //hide back button for the main menu
        self.navigationItem.hidesBackButton = true
        //hide the abandon hunt button if no hunt is currently going
        if let a = gameController.currentHunt{
            quitHuntButton.hidden = false
        }else{
            quitHuntButton.hidden = true
        }
        if let a = gameControllerSingleton.currentHunt {
            print("[MainViewController] game is running")
        } else {
            gameControllerSingleton.allGameModes = []
            httpController.getGameModes()
        }
        
        
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
            //print("[GameScreen] Jeeben huuben this is popup je je")
            isDisplayingPopup = true
            let popCreator = PopupCreator()
            popCreator.createClueFoundPopup(self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    @IBAction func quitCurrentHunt(sender: UIButton) {
        let popCreator = PopupCreator()
        popCreator.createQuitHuntPopup(self, buton: quitHuntButton)
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

