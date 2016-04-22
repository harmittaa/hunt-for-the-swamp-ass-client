//
//  GameModeObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class GameModeObject{
    var gameModeDescription: String?
    var gameModeThumbnailPath: String?
    var gameModeTitle: String?
    var gameModeId: Int
    var huntList: [HuntObject]
    let gameModeMedia: String
    var gameModeImage: UIImage?
    
    init(gameDesc: String, gameTitle: String, id: Int, gameModeMedia: String){
        self.gameModeTitle = gameTitle
        self.gameModeDescription = gameDesc
        self.gameModeId = id
        self.gameModeMedia = gameModeMedia
        self.huntList = [HuntObject]()
    }
    
    // set image for the gamemode
    func setImage(image: UIImage) {
        self.gameModeImage = image
    }
}