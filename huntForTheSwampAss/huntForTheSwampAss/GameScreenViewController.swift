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
    var marker: MKPointAnnotation?
    
    //MARK: location manager shenanigans
    override func viewDidLoad() {
        super.viewDidLoad()
        // ask the user to auth location always
        locationManager.requestAlwaysAuthorization()
        // set locationManager as the delegate for CLLocationManager to receive
        locationManager.delegate = self
        registerAsObserver()
        // checks if the third clue has been unlocked, and drops a pin if it has been
        checkClueStatus()
    }
    
    // This is called when the view appears, the check for any additional markers to be put on the map is done
    // also fethces images for clues and locations if the game has been resumed from CoreData
    override func viewDidAppear(animated: Bool) {
        checkClueStatus()
        gameController.updateSavedHunt()
        gameControllerSingleton.updateSavedHuntFromCurrentHunt()
        if gameControllerSingleton.currentHunt?.dataFetched == nil || gameControllerSingleton.currentHunt?.dataFetched == false {
            print("[GameScreenViewController]data for clues and locations hasn't been fetched")
            httpRequestControllerSingleton.getImages((gameControllerSingleton.currentHunt?.locationList)!)
            httpRequestControllerSingleton.getImagesForLocations((gameControllerSingleton.currentHunt?.locationList)!)
            // sets the data as fetched
            gameControllerSingleton.currentHunt?.setDataFetched(true)
        } else {
            print("[GameScreenViewController]data for clues and locatios has been fetched")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // if the third clue is unlocked sets a marker on the map
    func checkClueStatus() {
        if gameControllerSingleton.currentLocation?.clueList[2].lockedStatus == false {
            // Create the marker
            marker = MKPointAnnotation()
            // set coordinates from the cluemedia to the marker
            let coordinates: String = (gameControllerSingleton.currentLocation?.clueList[2].clueMedia)!
            let coordArr = coordinates.componentsSeparatedByString("/")
            marker!.coordinate = CLLocationCoordinate2D(
                latitude: Double(coordArr[0])!,
                longitude: Double(coordArr[1])!
            )
            marker!.title = gameControllerSingleton.currentLocation?.locationTitle
            gameScreenMap.addAnnotation(marker!)
        }
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
