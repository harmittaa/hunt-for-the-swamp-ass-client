//
//  Location.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class LocationObject:Equatable{
    var beacon: BeaconObject?
    var clueList: [ClueObject]
    var winDesc: String
    var winTitle: String
    var isFound: Bool
    var locationId: Int
    
    init(winTit:String,windDes: String, id: Int){
        self.isFound = false
        self.winDesc = windDes
        self.winTitle = winTit
        clueList = [ClueObject]()
        locationId = id
    }
    
    func resetLocation(){
        self.isFound = false
    }
}

func ==(lhs: LocationObject, rhs: LocationObject) -> Bool {
    return lhs.locationId == rhs.locationId
}