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
    var clueImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // if the clue doesn't have an image
        if passedClue?.hasImage != true {
            // hide the clueViewImage
            clueViewImage.hidden = true
            // parse the coordinates from the clueMedia string
            let coordinates: String = (passedClue?.clueMedia)!
            let coordArr = coordinates.componentsSeparatedByString("/")
            // center the map
            clueViewMap.centerCoordinate = CLLocationCoordinate2D(latitude: Double(coordArr[0])!, longitude: Double(coordArr[1])!)
            let location = CLLocation(latitude: Double(coordArr[0])!, longitude: Double(coordArr[1])!)
            // define the zoom distance
            let regionRadius: CLLocationDistance = 250
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
            // set the map on the certain location and zoom it.
            clueViewMap.setRegion(coordinateRegion, animated: true)
        } else {
            // the clue has an image
            clueViewMap.hidden = true
            clueViewImage.image = passedClue?.clueImage
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
