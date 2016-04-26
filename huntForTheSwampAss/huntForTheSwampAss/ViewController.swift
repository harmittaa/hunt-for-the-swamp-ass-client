//
//  ViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 5.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.


// Daniel: iosdev.example.huntForTheSwampAss
// matti: fi.metropolia.huntForTheSwampAss

import UIKit
import CoreData

class ViewController: UIViewController, ViewObserverProtocol {

    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var quitHuntButton: UIButton!
    @IBOutlet weak var testContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //let 🌚:DataController = DataController.dataManagerSingleton
    let gameController = gameControllerSingleton
    let httpController = httpRequestControllerSingleton
    var isDisplayingPopup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[ViewController] init values of GC: \(gameController.currentHunt)")
        //set BG image
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFit
        backgroundImage.image = UIImage(named: "main_menu_bg")
        //hide back button for the main menu
        self.navigationItem.hidesBackButton = true
        //hide the abandon hunt button if no hunt is currently going
        if let a = gameController.currentHunt{
            quitHuntButton.hidden = false
        }else{
            quitHuntButton.hidden = true
        }
        if let a = gameControllerSingleton.currentHunt {
            print("[MainViewController] game is already running")
        } else {
            gameControllerSingleton.allGameModes = []
            httpController.getGameModes()
        }
        registerAsObserver()
        beaconFinderSingleton.startScanningBeacon()
    }
    
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
        //gameControllerSingleton.completeHunt()

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "TestSegue"){
            let destinationSegue = segue.destinationViewController as? TestImageContainerViewController
            destinationSegue?.passefSelf = testContainer
        }
    }

}

