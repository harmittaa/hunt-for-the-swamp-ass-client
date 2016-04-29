//
//  UserObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 29.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class UserObject {
    var userID: Int
    var userName: String
    var userDesc: String
    var userImage: UIImage?
    var userImagePath: String
    
    init(usrID: Int, usrName: String, usrDesc: String, userImagePath: String){
        self.userDesc = usrDesc
        self.userID = usrID
        self.userImagePath = userImagePath
        self.userName = usrName
    }
}