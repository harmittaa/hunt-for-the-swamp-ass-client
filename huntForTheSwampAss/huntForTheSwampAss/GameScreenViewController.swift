//
//  GameScreenViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class GameScreenViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var gameScreenMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: location manager shenanigans
        let locationManager = CLLocationManager()
        //ask user to enable GPS
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            //tell the map to display currenty location
            gameScreenMap.showsUserLocation = true
            //create a coordinate object, that has a longitude and latitude
            let coordinate = locationManager.location!.coordinate
            //set delegate and desired accuracy of the GPS for the locationmanagager
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            //start location manager
            locationManager.startUpdatingLocation()
            //create a starting location for the map, use current position to center map on user
            let startLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            centerMapOnLocation(startLocation)
            
            //MARK: creating a blip on the map
            let mapBlip = MKPointAnnotation()
            mapBlip.coordinate = CLLocationCoordinate2D(
                latitude: 60.21846,
                longitude: 24.810916
            )
            mapBlip.title = "Sello"
            mapBlip.subtitle = "On kauppa"
            gameScreenMap.addAnnotation(mapBlip)
            
            // Do any additional setup after loading the view.
        }}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        gameScreenMap.setRegion(coordinateRegion, animated: true)
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
