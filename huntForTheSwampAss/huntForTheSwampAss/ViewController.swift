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
import CoreBluetooth
class ViewController: UIViewController, ViewObserverProtocol, CBCentralManagerDelegate{
    
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var quitHuntButton: UIButton!
    @IBOutlet weak var testContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    var bluetoothChecker: CBCentralManager?
    @IBOutlet weak var gameButton: UIButton!
    
    //let 🌚:DataController = DataController.dataManagerSingleton
    let gameController = gameControllerSingleton
    let httpController = httpRequestControllerSingleton
    var isDisplayingPopup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var bluetoothChecker = CBCentralManager(delegate: self, queue: nil)
        print("[ViewController] init values of GC: \(gameController.currentHunt)")
        //set BG image
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFit
        backgroundImage.image = UIImage(named: "main_menu_bg")
        //hide back button for the main menu
        self.navigationItem.hidesBackButton = true
        //check for a ongoin hunt, load images if present
        if gameControllerSingleton.currentHunt != nil{
            if gameControllerSingleton.currentHunt?.dataFetched == nil || gameControllerSingleton.currentHunt?.dataFetched == false {
                print("[GameScreenViewController]data for clues and locations hasn't been fetched")
                httpRequestControllerSingleton.getImages((gameControllerSingleton.currentHunt?.locationList)!)
                httpRequestControllerSingleton.getImagesForLocations((gameControllerSingleton.currentHunt?.locationList)!)
                // sets the data as fetched
                gameControllerSingleton.currentHunt?.setDataFetched(true)
            } else {
                print("[GameScreenViewController]data for clues and locatios has been fetched")
            }
        }
        //hide the abandon hunt button if no hunt is currently going
        if let a = gameController.currentHunt{
            quitHuntButton.hidden = false
        }else{
            quitHuntButton.hidden = true
        }
        if let a = gameControllerSingleton.currentHunt {
            print("[MainViewController] game is already running")
            //    gameButton.setTitle("Continue", forState: .Normal)
        } else {
            //     gameButton.setTitle("Game", forState: .Normal)
            gameControllerSingleton.allGameModes = []
            httpController.getGameModes()
        }
        registerAsObserver()
        beaconFinderSingleton.startScanningBeacon()
    }
    
    override func viewDidAppear(animated: Bool) {
        if gameControllerSingleton.currentHunt != nil {
            gameControllerSingleton.updateSavedHuntFromCurrentHunt()
        }
        //let saveHunt = dataManagerSingleton.createSaveHunt(gameController.allGameModes![0].huntList[0])
        //print("[viewCtrl] this savebale hunt was created: \(saveHunt)")
        /*var bluetoothIsOn = false
         while !bluetoothIsOn{//bluetoothChecker.state != CBCentralManagerState.PoweredOn{
         print("[viewctrl] bluetooth is off, looping + \(bluetoothIsOn)")
         if bluetoothChecker.state != CBCentralManagerState.PoweredOn {
         print("[viewctrl] making new centralmanager")
         //bluetoothChecker = CBCentralManager(delegate: self, queue: nil)
         }
         else{
         print("[viewctrl] bluetooth is on, should stop looping")
         bluetoothIsOn = true
         }
         }*/
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
        if bluetoothChecker == nil {
            bluetoothChecker = CBCentralManager(delegate: self, queue: nil)
        }
        if bluetoothChecker!.state != CBCentralManagerState.PoweredOn{
            bluetoothChecker = CBCentralManager(delegate: self, queue: nil)
            print("[viewctrl] BL not powered on")
        }else {
            print("[viewctrl] seguenow!")
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "TestSegue"){
            let destinationSegue = segue.destinationViewController as? TestImageContainerViewController
            destinationSegue?.passefSelf = testContainer
        }
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOff{
            print("[viewctrl] BL is powered off")
        }
        else if central.state == CBCentralManagerState.PoweredOn{
            print("[viewctrl] BL is powered on")
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
    
    /*
     func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
     print("[viewctrl] start of did update state")
     if peripheral.state == CBPeripheralManagerState.PoweredOn {
     print("[ViewCtrl] Bluetooth is turned on")
     } else if peripheral.state == CBPeripheralManagerState.PoweredOff {
     print("[viewctrl] bluetooth is off")
     } else if peripheral.state == CBPeripheralManagerState.Unsupported {
     print("[viewctrl] bluetooth is Unsupported")
     } else if peripheral.state == CBPeripheralManagerState.Unauthorized {
     print("[viewctrl] bluetooth is unauthorized")
     }
     }
     */
}

