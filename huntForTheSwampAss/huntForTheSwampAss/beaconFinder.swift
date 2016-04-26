//
//  beaconFinder.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 11.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
// 

import Foundation
import CoreLocation

let beaconFinderSingleton = BeaconFinder()
let gameController = gameControllerSingleton
class BeaconFinder: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")!, identifier: "ble_beacon")
    var listOfObservers = [ViewObserverProtocol]()
    
    private override init(){
        super.init()
        print("[beaconfinder] init")
        //let locationManager = CLLocationManager()
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestAlwaysAuthorization()
            print("[beaconfinder] init auth status is \(CLLocationManager.authorizationStatus())")
        }
        self.locationManager.delegate = self
        locationManager.startRangingBeaconsInRegion(region)
        startScanningBeacon()
    }
    
    //MARK: beacon found
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        print("[beaconfider] location manager method")
        //filer out uknown beacon, they are too far
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        //perform actions if beacons are found
        print(knownBeacons)
        if let asd = gameController.currentLocation{
            if (knownBeacons.count > 0) {
                for b in knownBeacons{
                    let convertedBeacon = BeaconObject(beaconmajor: b.major.integerValue, beaconminor: b.minor.integerValue)
                    print("[beaconFinder] comparing beacons: -Current- \(gameController.currentLocation!.beacon!.beaconMajor) -found- \(convertedBeacon.beaconMajor)")
                    print("[beaconFinder] comparing beacons: -Current- \(gameController.currentLocation!.beacon!.beaconMinor) -found- \(convertedBeacon.beaconMinor)")
                    if(gameController.currentLocation?.beacon == convertedBeacon){
                        if(!gameController.currentLocation!.isFound){
                            print("[BeaconFinder]!!!!! FOUND CORRECT BEACON !!!!!")
                            updateObservers()
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        print("[BeaconFinder] state: \(state) and region is \(region)")
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("[BeaconFinder] region is \(region)")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("[BeaconFinder] exit region is \(region)")
    }
    
    func startScanningBeacon(){
        print("[BeaconFinder] starting beacon scan")
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
            print("bluetooth not on")
            print("[beaconfinder] scanning auth status is \(CLLocationManager.authorizationStatus().rawValue)")
           // locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        }
        else {
            print("[BeaconFinder] bluetooth on")
        }
       // locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringForRegion(region)
        locationManager.startRangingBeaconsInRegion(region)
        locationManager.startUpdatingLocation()
        
        print("[BeaconFinder]Monitoring the following regions: \(locationManager.monitoredRegions)")
    }
    
    func registerAsObserver(observer: ViewObserverProtocol){
        self.listOfObservers.append(observer)
    }
    
    func updateObservers(){
        for a in listOfObservers{
            a.receiveNotification()
            //print("[BeaconFinder] sending notification to: \(a)")
        }
    }
}
