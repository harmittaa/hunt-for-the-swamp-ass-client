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

class BeaconFinder: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")!, identifier: "ble_beacon")
    
    
    private override init(){
        super.init()
        //let locationManager = CLLocationManager()
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.delegate = self
        locationManager.startRangingBeaconsInRegion(region)
    }
    //MARK: beacon found
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        //TODO: update observers here
        //filer out uknown beacon, they are too far
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        //perform actions if beacons are found
        if (knownBeacons.count > 0) {
                //pick out the first beacon from the list. they are automatically sorted from closest to farthest, downcast it as a CLBeacon
                let closestBeacon = knownBeacons[0] as CLBeacon
                print("[BeaconFinder] new closest beacon: \(closestBeacon.proximityUUID) + \(closestBeacon.proximity.rawValue) + \(closestBeacon.major)")
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
}
