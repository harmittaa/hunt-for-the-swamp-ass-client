//
//  NewLocationViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

//!!!! THIS VIEW IS NOT AN OBSERVER !!!!!!
// this is shown when user finds a location

import UIKit

class NewLocationViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var newLocationBG: UIImageView!
    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var locationFoundTitle: UILabel!
    @IBOutlet weak var locationFoundImage: UIImageView!
    @IBOutlet weak var locationFoundTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //disable back button so user has to advance to next clue
        self.navigationItem.hidesBackButton = true
        //set dscription
        locationFoundTextField.text = gameControllerSingleton.currentLocation?.winDesc
        locationFoundTextField.backgroundColor = UIColor.clearColor()
        //set shadows for description
        locationFoundTextField.layer.shadowColor = UIColor.blackColor().CGColor
        locationFoundTextField.layer.shadowOffset = CGSizeMake(1, 1)
        locationFoundTextField.layer.shadowOpacity = 1
        locationFoundTextField.layer.shadowRadius = 0
        locationFoundTextField.backgroundColor = UIColor.clearColor()
        locationFoundTextField.textColor = UIColor.whiteColor()
        locationFoundTextField.font = UIFont(name: "courier", size: 18)
        //set title
        locationFoundTitle.text = gameControllerSingleton.currentLocation?.locationTitle
        locationFoundImage.image = gameControllerSingleton.currentLocation!.locationImage
        //set image and background
        locationFoundImage.contentMode = UIViewContentMode.ScaleAspectFit
        newLocationBG.image = UIImage(named: "hunts_bg")
        //newLocationBG.contentMode = UIViewContentMode.ScaleAspectFit
        //set points label text
        pointsLabel.text = "Points: \(gameControllerSingleton.pointsCalculateForFinishedLocation())"
        print("[locationFound] reference: size of paragraph: \(locationFoundTextField.frame.size)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contienuButtonAction(sender: UIButton) {
        if(!gameController.isAllLocationFound()){
            //add to current points
            gameControllerSingleton.pointsUpdateTotalPoints(gameControllerSingleton.pointsCalculateForFinishedLocation())
            let newLocationIndex = gameController.currentHunt?.locationList!.indexOf(gameController.currentLocation!)
            print("[newLocation] index is: \(newLocationIndex!)")
            gameController.currentLocation = gameController.currentHunt?.locationList![newLocationIndex!+1]
            print("[newLocation] new location is \(gameController.currentLocation?.locationId)")
            gameControllerSingleton.updateSavedHuntFromCurrentHunt()
            performSegueWithIdentifier("LocationCompleteSegue", sender: self)
        }
        else{
            gameControllerSingleton.pointsUpdateTotalPoints(gameControllerSingleton.pointsCalculateForFinishedLocation())
            performSegueWithIdentifier("HuntCompleteSegue", sender: self)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "LocationMediaSegue"{
            let destCtrl = segue.destinationViewController as! LocationFoundMediaViewController
            destCtrl.passedSelf = mediaContainer
            destCtrl.isHunt = false
        }
        
        
    }
}
