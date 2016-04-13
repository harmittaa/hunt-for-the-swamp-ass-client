//
//  GameScreenTabBarController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class GameScreenTabBarController: UITabBarController, ViewObserverProtocol {

    let gameController = gameControllerSingleton
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //disable back button so user can only go to main menu now
        self.navigationItem.hidesBackButton = true
        registerAsObserver()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToMainMenu(sender: UIBarButtonItem) {
        print("[GameTabController] main menu pressed")
    }
    
    //MARK: Obeserver functions
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    func receiveNotification() {
        let noAuthAlert = UIAlertController.init(title: "gameController.currentLocation!.locationTitle", message: "Found a thing", preferredStyle: .Alert)
        print("[ViewController] received notification as observer")
        //custom action with a segue
        let settingsAction = UIAlertAction(title: "Continue", style: .Default, handler: { (testAction) -> Void in
            self.performSegueWithIdentifier("LocationDiscoveredSegue", sender: self)
            self.gameController.currentLocation!.isFound = true
        })
        // add actions to the alert
        noAuthAlert.addAction(settingsAction)
        presentViewController(noAuthAlert, animated: true, completion: nil)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
