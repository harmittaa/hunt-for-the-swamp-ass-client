//
//  FullClueViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class FullClueViewController: UIViewController {
    var passedClue: ClueObject!
    @IBOutlet weak var clueMedia: UIImageView!
    @IBOutlet weak var clueDesc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clueDesc.text = passedClue.clueText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
