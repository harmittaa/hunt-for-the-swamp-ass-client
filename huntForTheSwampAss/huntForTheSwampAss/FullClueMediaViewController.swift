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
    var marker:MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if the clue doesn't have an image
        if passedClue?.hasImage == false {
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
            // If the clue tier is 1 it means that the map will be static without any information
            // if the tier is 3, then drops a pin on the correct location
            if passedClue?.clueTier == 0 {
                // set maptype as satellite
                clueViewMap.mapType = MKMapType.Satellite
                // with these settings user can't interact with the map
                clueViewMap.zoomEnabled = false
                clueViewMap.scrollEnabled = false
                clueViewMap.pitchEnabled = false
                clueViewMap.rotateEnabled = false
                clueViewMap.showsPointsOfInterest = false
                clueViewMap.userInteractionEnabled = false
            } else {
                // set maptype as satellite
                clueViewMap.mapType = MKMapType.HybridFlyover
                // with these settings user can't interact with the map
                marker = MKPointAnnotation()
                marker!.coordinate = CLLocationCoordinate2D(
                    latitude: Double(coordArr[0])!,
                    longitude: Double(coordArr[1])!
                )
               // marker!.title = "name here"
                clueViewMap.addAnnotation(marker!)
                clueViewMap.zoomEnabled = false
                clueViewMap.scrollEnabled = false
                clueViewMap.pitchEnabled = false
                clueViewMap.rotateEnabled = false
                clueViewMap.showsPointsOfInterest = true
                clueViewMap.userInteractionEnabled = false
            }
            
        } else if passedClue?.hasImage == true {
            // the clue has an image
            clueViewMap.hidden = true
            clueViewImage.image = passedClue?.clueImage
            clueViewImage.contentMode = UIViewContentMode.ScaleAspectFit
            clueViewImage.backgroundColor = UIColor.clearColor()
            clueViewImage.frame = CGRectMake(0, 0, clueViewImage.image!.size.width, clueViewImage.image!.size.height)
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
