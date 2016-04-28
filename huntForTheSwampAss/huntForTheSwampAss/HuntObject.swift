//
//  HuntObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class HuntObject{
    var huntID: Int?
    var huntDescription: String?
    var huntEndDate: NSDate?
    var huntStartDate: NSDate?
    var huntThumbnailPath: String?
    var huntTitle: String
    var winTitle: String
    var winDesc: String
    var locationList: [LocationObject]?
    var huntMedia: String
    var huntImage: UIImage?
    
    init(title: String, desc: String,winTit: String, winDes: String, huntMedia: String){
        self.huntTitle = title
        self.huntDescription = desc
        self.huntStartDate = NSDate()
        self.winTitle = winTit
        self.winDesc = winDes
        self.huntMedia = huntMedia
        self.locationList = [LocationObject]()
    }
    
    func resetAllLocations(){
        for a in self.locationList!{
            a.resetLocation()
        }
    }
    
    // set image for the hunt
    func setImage(image: UIImage) {
        self.huntImage = image
    }
}