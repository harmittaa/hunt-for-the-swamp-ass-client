//
//  ClueObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class ClueObject{
    let clueText: String
    let clueTier: Int
    var lockedStatus: Bool
    let clueTitle: String
    
    init(clueTitle: String, cluetext: String, cluetier:Int){
        self.clueText = cluetext
        self.clueTier = cluetier
        self.clueTitle = clueTitle
        if(clueTier < 1){
            self.lockedStatus = false
        }else{
            self.lockedStatus = true
        }
    }
}