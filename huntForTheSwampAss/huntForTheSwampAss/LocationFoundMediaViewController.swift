//
//  LocationFoundMediaViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 25.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class LocationFoundMediaViewController: UIViewController {
    var passedSelf: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //image and imageview
        let imageToDisplay = gameControllerSingleton.currentHunt!.huntImage
        let imageToDisplayView = UIImageView(image: imageToDisplay)
        //sizes
        let currentSizeOfView = imageToDisplayView.frame.size
        let containerSize = passedSelf!.frame.size
        let testSize = CGSize(width: self.view.frame.size.width-32, height: containerSize.height)
        //resizer
        let resizer = ImageResizer()
        let newSize = resizer.calculateNewDimensionsOfImage(currentSizeOfView, containerDimension: testSize)
        //modifying size of imageView
        print("[mediaLocationFound] seize of 'self' \(self.view.frame.size)")
        imageToDisplayView.frame = CGRectMake(0, 0, newSize.width, newSize.height)
        //add view to the container
        self.view.addSubview(imageToDisplayView)
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
