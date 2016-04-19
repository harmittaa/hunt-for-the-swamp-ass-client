//
//  GameModeObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class GameModeObject{
    var gameModeDescription: String?
    var gameModeThumbnailPath: String?
    var gameModeTitle: String?
    var gameModeId: Int
    var huntList: [HuntObject]?
    
    init(gameDesc: String, gameTitle: String, huntsInGame: [HuntObject], id: Int){
        self.gameModeTitle = gameTitle
        self.gameModeDescription = gameDesc
        self.huntList = huntsInGame
        self.gameModeId = id
    }
    
    init(gameDesc: String, gameTitle: String, id: Int){
        self.gameModeTitle = gameTitle
        self.gameModeDescription = gameDesc
        self.gameModeId = id
    }
}