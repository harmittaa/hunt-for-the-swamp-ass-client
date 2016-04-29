//
//  FullClueViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class FullClueViewController: UIViewController, ViewObserverProtocol {
    var passedClue: ClueObject!
    
    @IBOutlet weak var clueTitle: UILabel!
    @IBOutlet weak var clueMediaView: UIView!
    @IBOutlet weak var clueDesc: UITextView!
    let gameController = gameControllerSingleton
   // let beaconFinder = beaconFinderSingleton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clueDesc.text = passedClue.clueText
        clueTitle.text = passedClue.clueTitle
        // Do any additional setup after loading the view.
        registerAsObserver()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hunts_bg")!)
        //adding a shadow to text view
        clueDesc.layer.shadowColor = UIColor.blackColor().CGColor
        clueDesc.layer.shadowOffset = CGSizeMake(1, 1)
        clueDesc.layer.shadowOpacity = 1
        clueDesc.layer.shadowRadius = 0
        clueDesc.backgroundColor = UIColor.clearColor()
        clueDesc.textColor = UIColor.whiteColor()
        clueDesc.font = UIFont(name: "courier", size: 18)
        //set media container BG to transparent
        clueMediaView.backgroundColor = UIColor.clearColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveNotification() {
        let noAuthAlert = UIAlertController.init(title: "gameController.currentLocation!.locationTitle", message: "Found a thing", preferredStyle: .Alert)
        print("[ViewController] received notification as observer")
        //custom action with a segue
        let settingsAction = UIAlertAction(title: "Continue", style: .Default, handler: { (testAction) -> Void in
            self.performSegueWithIdentifier("LocationDiscoveredSegue", sender: self)
            gameControllerSingleton.currentLocation!.isFound = true
        })
        // add actions to the alert
        noAuthAlert.addAction(settingsAction)
        presentViewController(noAuthAlert, animated: true, completion: nil)
    }
    
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "clueMediaSegue"){
            let mediaContainer = segue.destinationViewController as! FullClueMediaViewController
            mediaContainer
            mediaContainer.passedClue = self.passedClue
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
