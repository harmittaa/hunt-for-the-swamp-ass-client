//
//  gameMode.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class GameMode{
    var huntList = [Hunt]()
    let gameModeName: String!
    let gameModeDesc: String!
    init(name: String){
        self.gameModeName = name
        self.gameModeDesc = "description goes here"
        self.huntList.append(Hunt(name: "testHunt"))
        self.huntList.append(Hunt(name: "testiHuntti"))
        
    }
}
