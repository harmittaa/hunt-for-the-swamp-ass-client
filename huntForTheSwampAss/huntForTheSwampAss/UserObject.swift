//
//  UserObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 29.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
class UserObject{
    
    var userID: Int
    var userName: String
    var userDesc: String
    var userImage: UIImage
    
    init(usrID: Int,usrName: String,usrDesc:String,usrImg:UIImage){
        self.userDesc = usrDesc
        self.userID = usrID
        self.userImage = usrImg
        self.userName = usrName
    }
}