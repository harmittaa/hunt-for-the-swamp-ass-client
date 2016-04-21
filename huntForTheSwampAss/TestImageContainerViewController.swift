//
//  TestImageContainerViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class TestImageContainerViewController: UIViewController {
    var passefSelf: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        getImageFromUrl()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImageFromUrl(){
        let url = NSURL(string:"https://www.integer-research.com/wp-content/uploads/2014/07/red-cross-small-60x60.jpg")
        let data = NSData(contentsOfURL:url!)
        if data != nil{
            let tempImg = UIImage(data: data!)
            let kuvakoko: CGSize = tempImg!.size
            let testImageView = UIImageView(image: tempImg)
            //testImageView.bounds = CGRectMake(0, 0, 50, 50)//tempImg//UIImage(data:data!)
            let correctSize = calculateNewDimensionsOfImage(kuvakoko)
            print("[sizecalc] new size of image: \(correctSize.height) + \(correctSize.width)")
            testImageView.frame = CGRectMake(0, 0, correctSize.width, correctSize.height)
            testImageView.frame.origin.x = ((passefSelf!.bounds.size.width - testImageView.frame.size.width)/2)
            self.view.addSubview(testImageView)
        }
    }
    //calculate the correct size for a image so it can fit inside the container and not be distorted
    func calculateNewDimensionsOfImage(imageDimension: CGSize) -> CGSize{
        let currentSize = self.passefSelf!.frame.size
        print("[sizecalc] received size: \(imageDimension.height) + \(imageDimension.width)")
        print("[sizecalc] container size: \(currentSize.height) + \(currentSize.width)")
        //check image dimensions, which way it will get cropped
        if(imageDimension.height >= imageDimension.width){
            //check if the image is smaller or bigger than the container, this determines if it will be shrunk or stretched
            let aspectRatio = currentSize.height / imageDimension.height
            return CGSize(width: (imageDimension.width * aspectRatio), height: currentSize.height)
        }
        else{
            let aspectRatio = currentSize.width / imageDimension.width
            return CGSize(width: currentSize.width, height: (imageDimension.height*aspectRatio))
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
