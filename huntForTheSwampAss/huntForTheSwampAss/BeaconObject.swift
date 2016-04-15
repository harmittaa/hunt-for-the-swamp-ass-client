//
//  BeaconObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class BeaconObject: Equatable{
     let beaconMajor: Int
     let beaconMinor: Int
     let beaconRSSI: Int
     let beaconUUID: String?
    //beaconuuid has a default value if no value is provided
    init(beaconmajor: Int, beaconminor: Int, beaconuuid: String = "00000000-0000-0000-0000-000000000000"){
        self.beaconMajor = beaconmajor
        self.beaconMinor = beaconminor
        self.beaconRSSI = 0
        self.beaconUUID = beaconuuid ?? "00000000-0000-0000-0000-000000000000"
    }
}
//MARK: comparation funciton
func ==(lhs: BeaconObject, rhs: BeaconObject) -> Bool {
    return (lhs.beaconMajor == rhs.beaconMajor && lhs.beaconMinor == rhs.beaconMinor)
}