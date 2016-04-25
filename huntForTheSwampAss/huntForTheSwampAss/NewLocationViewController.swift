//
//  NewLocationViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

//!!!! THIS VIEW IS NOT AN OBSERVER !!!!!!

import UIKit

class NewLocationViewController: UIViewController {

    @IBOutlet weak var locationFoundTitle: UILabel!
    @IBOutlet weak var locationFoundImage: UIImageView!
    @IBOutlet weak var locationFoundTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //disable back button so user has to advance to next clue
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        locationFoundTextField.text = gameControllerSingleton.currentLocation?.winDesc
        locationFoundTitle.text = gameControllerSingleton.currentLocation?.winTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contienuButtonAction(sender: UIButton) {
        if(!gameController.isAllLocationFound()){
        let newLocationIndex = gameController.currentHunt?.locationList!.indexOf(gameController.currentLocation!)
        print("[newLocation] index is: \(newLocationIndex!)")
        gameController.currentLocation = gameController.currentHunt?.locationList![newLocationIndex!+1]
        print("[newLocation] new location is \(gameController.currentLocation?.locationId)")
        performSegueWithIdentifier("LocationCompleteSegue", sender: self)
        }
        else{
            performSegueWithIdentifier("HuntCompleteSegue", sender: self)
        }
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
