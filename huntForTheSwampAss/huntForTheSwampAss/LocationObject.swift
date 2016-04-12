//
//  Location.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class LocationObject{
    var locationTitle: String
    var beacon: BeaconObject
    var clueList: [ClueObject]
    var completion: Completion?
    
    init(title: String, beacon: BeaconObject){
        self.locationTitle = title
        self.beacon = beacon
        clueList = [ClueObject(cluetext: "Liirum Laarum Peruna Tier 1 clue", cluetier: 1),ClueObject(cluetext: "Liirum Laarum Peruna Tier 2 clue", cluetier: 2),ClueObject(cluetext: "Liirum Laarum Peruna Tier 3 clue", cluetier: 3)]
    }
}