//
//  ClueObject.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class ClueObject{
    let clueText: String
    let clueTier: Int
    var lockedStatus: Bool
    let clueTitle: String
    let clueMedia: String
    var hasImage: Bool?
    var clueImage: UIImage?
    
    
    init(clueTitle: String, cluetext: String, cluetier:Int, clueMedia: String){
        self.clueText = cluetext
        self.clueTier = cluetier
        self.clueTitle = clueTitle
        self.clueMedia = clueMedia
        
        if(clueTier < 1){
            self.lockedStatus = false
        }else{
            self.lockedStatus = true
        }
    }
    
    // set the image for the clue
    func setImage(image: UIImage) {
        self.clueImage = image
        self.hasImage = true
    }
    
    // set the boolean if there is no image, i.e. false
    func setImageBool(status: Bool) {
        self.hasImage = status;
    }

    func resetClue(){
        if self.clueTier > 0{
            print("[CLUE] resetted clue!")
            self.lockedStatus = true
        }
    }
}