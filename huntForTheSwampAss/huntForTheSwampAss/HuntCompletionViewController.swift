//
//  HuntCompletionViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class HuntCompletionViewController: UIViewController {

    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var huntCompletionTitle: UILabel!
    @IBOutlet weak var huntCompletionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = "Congratulations!"
        huntCompletionText.text = gameControllerSingleton.currentHunt!.winDesc
        huntCompletionTitle.text = gameControllerSingleton.currentHunt!.winTitle
        gameControllerSingleton.completeHunt()    }

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
