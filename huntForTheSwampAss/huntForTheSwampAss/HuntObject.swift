//
//  HuntObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class HuntObject{
    
    var huntDescription: String?
    var huntEndDate: NSDate?
    var huntStartDate: NSDate
    var huntThumbnailPath: String?
    var huntTitle: String
    var completion: Completion?
    var locationList: [LocationObject]
    
    init(title: String, desc: String?, locations: [LocationObject]){
        self.huntTitle = title
        if let a = desc {
            self.huntDescription = desc
        }
        self.huntStartDate = NSDate()
        self.locationList = locations
    }
    
}