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
    
    init(cluetext: String, cluetier:Int){
        self.clueText = cluetext
        self.clueTier = cluetier
    }
}