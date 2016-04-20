//
//  FullClueMediaViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 20.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit
import MapKit
class FullClueMediaViewController: UIViewController {
    
    @IBOutlet weak var clueViewMap: MKMapView!
    @IBOutlet weak var clueViewImage: UIImageView!
    var passedClue: ClueObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let a = passedClue{
            if(passedClue?.clueTier > 2){
                clueViewImage.hidden = true
            }else{
                clueViewMap.hidden = true
            }
        }
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
