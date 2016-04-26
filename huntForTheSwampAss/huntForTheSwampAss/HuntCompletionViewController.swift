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
    
    @IBOutlet weak var huntCompleteImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = "You Did It!"
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
}
