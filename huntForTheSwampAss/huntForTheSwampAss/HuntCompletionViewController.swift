//
//  HuntCompletionViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class HuntCompletionViewController: UIViewController {

    @IBOutlet weak var huntCompletionBG: UIImageView!
    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var huntCompletionTitle: UILabel!
    @IBOutlet weak var huntCompletionText: UITextView!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var huntCompleteImage: UIImageView!
    @IBOutlet weak var timeToComplete: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = "You Won!"
        //set image
        huntCompleteImage.image = gameControllerSingleton.currentHunt!.huntImage
        huntCompleteImage.contentMode = UIViewContentMode.ScaleAspectFit
        //set description
        huntCompletionText.text = gameControllerSingleton.currentHunt!.winDesc
        huntCompletionText.backgroundColor = UIColor.clearColor()
        //set shadows for description
        huntCompletionText.layer.shadowColor = UIColor.blackColor().CGColor
        huntCompletionText.layer.shadowOffset = CGSizeMake(1, 1)
        huntCompletionText.layer.shadowOpacity = 1
        huntCompletionText.layer.shadowRadius = 0
        huntCompletionText.backgroundColor = UIColor.clearColor()
        huntCompletionText.textColor = UIColor.whiteColor()
        huntCompletionText.font = UIFont(name: "courier", size: 18)
        //set title
        huntCompletionTitle.text = gameControllerSingleton.currentHunt!.winTitle
        //set background
        huntCompletionBG.image = UIImage(named: "gamemode_bg")
        //set time to complete to label
        timeToComplete.text = "Time: \(stringFromTimeInterval(NSDate().timeIntervalSinceDate(gameControllerSingleton.huntStartDate!)))"
        //set total points to label
        totalPointsLabel.text = "Total Points: \(gameControllerSingleton.playerPoints + Int(gameControllerSingleton.pointsCalculateTimePointsForFinishedHunt()))"
        print("[huntcompletion] Time points for this round: \(Int(gameControllerSingleton.pointsCalculateTimePointsForFinishedHunt()))")
        gameControllerSingleton.completeHunt()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "LocationMediaSegue"{
            let destCtrl = segue.destinationViewController as! LocationFoundMediaViewController
            destCtrl.passedSelf = mediaContainer
            destCtrl.isHunt = true
        }
        
        
        
    }
    func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
        
        var ti = NSInteger(interval)
        
        var ms = Int((interval % 1) * 1000)
        
        var seconds = ti % 60
        var minutes = (ti / 60) % 60
        var hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}
