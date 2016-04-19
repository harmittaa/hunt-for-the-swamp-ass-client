//
//  JsonParser.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 18.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

// used for parsing json

import Foundation

class JsonParser {
    // make it easier for your fingers
    typealias Payload = [String: AnyObject]
    
    init () {
        print("[JSON] new parser created")
    }
    
    // called from HTTPRequestController once some data has been fetched
    func parseGameModes(data: NSData) {
        /*       do {
         // turn data into JSON that can be parsed, cast as Array of Payload type objects
         var json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! Array<Payload>
         
         // loop through the array
         for item in json {
         print("[JSON] parsed: ")
         print(item)
         // turn the item into an NSDictionary object so that data can be parsed easier
         var item2 = item as NSDictionary
         print(item2.objectForKey("id")!)
         }
         } catch {
         print("[JSON] error: ")
         print(error)
         } */
        
        do {
            print("[JSON] parsing should start")
            // Turns JSON data into a foundation objects
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            // makes a String:Anyobject list of the value from GameModes : [] pair
            if let gameModes = json["GameModes"] as? [Payload] {
                for gameMode in gameModes {
                    print("[JSON] Gamemode is: ")
                    print(gameMode)
                    // create object
                    let gameModeObject = GameModeObject(gameDesc: (gameMode["description"] as? String)!, gameTitle: (gameMode["title"] as? String)!, id: (gameMode["id"] as? Int)!)
                    gameControllerSingleton.allGameModes?.append(gameModeObject)
                }
            }
        } catch {
            print(error)
        }
        
    }
}