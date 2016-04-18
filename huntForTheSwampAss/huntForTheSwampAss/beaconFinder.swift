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
        //let locationManager = CLLocationManager()
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.delegate = self
        locationManager.startRangingBeaconsInRegion(region)
        startScanningBeacon()
    }
    //MARK: beacon found
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        //TODO: update observers here
        //filer out uknown beacon, they are too far
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        //perform actions if beacons are found
        if let asd = gameController.currentLocation{
            if (knownBeacons.count > 0) {
                for b in knownBeacons{
                    let convertedBeacon = BeaconObject(beaconmajor: b.major.integerValue, beaconminor: b.minor.integerValue)
                    print("[beaconFinder] comparing beacons: -Current- \(gameController.currentLocation!.beacon.beaconMajor) -found- \(convertedBeacon.beaconMajor)")
                    if(gameController.currentLocation?.beacon == convertedBeacon){
                        if(!gameController.currentLocation!.isFound){
                            print("[BeaconFinder]!!!!! FOUND CORRECT BEACON !!!!!")
                            updateObservers()
                        }
                    }
                }
            }
            /*
             //pick out the first beacon from the list. they are automatically sorted from closest to farthest, downcast it as a CLBeacon
             let closestBeacon = knownBeacons[0] as CLBeacon
             //print("[BeaconFinder] new closest beacon: \(closestBeacon.proximityUUID) + \(closestBeacon.proximity.rawValue) + \(closestBeacon.major)")
             if (closestBeacon.major == gameController.currentLocation?.beacon.beaconMajor && closestBeacon.proximity.rawValue < 3){
             if let g = gameController.currentLocation{
             //print("[BeaconFinder] current location of GC: \(g)")
             if(!g.isFound){
             print("[BeaconFinder]!!!!! FOUND CORRECT BEACON !!!!!")
             updateObservers()
             }
             }
             }*/
        }
        
    }
    func startScanningBeacon(){
        print("[BeaconFinder] starting beacon scan")
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            print("bluetooth not on")
            locationManager.requestWhenInUseAuthorization()
        }
        else {
            print("[BeaconFinder] bluetooth on")
        }
        locationManager.startRangingBeaconsInRegion(region)
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
