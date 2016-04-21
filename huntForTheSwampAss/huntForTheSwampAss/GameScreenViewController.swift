//
//  GameScreenViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

// Handles the map and location on the Game Screen


import UIKit
import MapKit
import CoreLocation
class GameScreenViewController: UIViewController, CLLocationManagerDelegate, ViewObserverProtocol{
    @IBOutlet weak var gameScreenMap: MKMapView!
    
    let locationManager = CLLocationManager()
    let gameController = gameControllerSingleton
    var isDisplayingPopup = false
    
    //MARK: location manager shenanigans
    override func viewDidLoad() {
        super.viewDidLoad()
        // ask the user to auth location always
        locationManager.requestAlwaysAuthorization()
        // set locationManager as the delegate for CLLocationManager to receive
        locationManager.delegate = self
        registerAsObserver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when auth status changes this method is called
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("[GameScreenViewController] Location manager delegate received notification that auth status has changed")
        print("[GameScreenViewController] Auth status is \(CLLocationManager.authorizationStatus().rawValue)")
        
        // if auth status is the AuthorizedAlways then location stuff is run
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            //tell the map to display currenty location
            gameScreenMap.showsUserLocation = true
            //create a coordinate object, that has a longitude and latitude
            let coordinate = locationManager.location!.coordinate
            //set delegate and desired accuracy of the GPS for the locationmanagager
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
            
            // if the user has declined the auth poop up screen
        } else if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.NotDetermined {
            print("[GameScreenViewController] Location has not been authorized")
            print(CLLocationManager.authorizationStatus().rawValue)
            
            // create an alert
            let noAuthAlert = UIAlertController.init(title: "No authorization", message: "Please authorize Hunt for the Swamp ass to see your location on map!", preferredStyle: .ActionSheet)
            
            // create an action for the alert that takes the user to location settings of the app
            let settingsAction = UIAlertAction(title: "Location settings", style: .Default, handler: { (testAction) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            })
            
            let mapImage = UIImage(named: "map")
            
            let imageView = UIImageView(frame: CGRect(x: 40, y: 40, width: 40, height: 40))
            imageView.image = mapImage
            
            noAuthAlert.view.addSubview(imageView)
            
            // create an action for the alert that cancels
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            // add actions to the alert
            noAuthAlert.addAction(cancelAction)
            noAuthAlert.addAction(settingsAction)
            
            // show the alert to user
            presentViewController(noAuthAlert, animated: true, completion: nil)
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        gameScreenMap.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: Obeserver functions
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    func receiveNotification() {
        if(!isDisplayingPopup){
            //print("[GameScreen] Jeeben huuben this is popup je je")
            isDisplayingPopup = true
            let popCreator = PopupCreator()
            popCreator.createClueFoundPopup(self)
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
