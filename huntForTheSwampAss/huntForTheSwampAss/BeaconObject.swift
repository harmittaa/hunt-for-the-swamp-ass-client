//
//  BeaconObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class BeaconObject{
     let beaconMajor: Int
     let beaconMinor: Int
     let beaconRSSI: Int
     let beaconUUID: String
    
    init(beaconmajor: Int, beaconminor: Int, beaconuuid: String){
        self.beaconMajor = beaconmajor
        self.beaconMinor = beaconminor
        self.beaconRSSI = 0
        self.beaconUUID = beaconuuid
    }
}
