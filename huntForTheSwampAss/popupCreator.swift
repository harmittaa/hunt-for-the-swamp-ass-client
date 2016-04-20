//
//  popupCreator.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 18.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
class PopupCreator{
    
    let gameController = gameControllerSingleton
    
    func createQuitHuntPopup(view: UIViewController, buton: UIButton){
        let noAuthAlert = UIAlertController.init(title: "Are you sure?", message: "", preferredStyle: .Alert)
        print("[ViewController] received notification as observer")
        //custom action with a segue
        let yesAction = UIAlertAction(title: "Yes", style: .Default, handler: { (testAction) -> Void in
            self.gameController.currentHunt = nil
            self.gameController.currentLocation = nil
            buton.hidden = true
        })
        let noAction = UIAlertAction(title: "No", style: .Cancel, handler: { (testAction) -> Void in
            
        })
        // add actions to the alert
        noAuthAlert.addAction(yesAction)
        noAuthAlert.addAction(noAction)
        view.presentViewController(noAuthAlert, animated: true, completion: nil)
        
    }
    
    func createClueFoundPopup(view: UIViewController){
        let noAuthAlert = UIAlertController.init(title: "Hey!", message: "You found your destination!", preferredStyle: .Alert)
        print("[ViewController] received notification as observer")
        //custom action with a segue
        
        let settingsAction = UIAlertAction(title: "Continue", style: .Default, handler: { (testAction) -> Void in
            view.performSegueWithIdentifier("LocationDiscoveredSegue", sender: self)
            self.gameController.currentLocation!.isFound = true
        })
        // add actions to the alert
        noAuthAlert.addAction(settingsAction)
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        view.presentViewController(noAuthAlert, animated: true, completion: nil)
        //})
    }
}