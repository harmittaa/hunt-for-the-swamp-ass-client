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
    init () {}
    
    func parseUser(data: NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
        } catch {
            print(error)
        }
    }
    
    // called from HTTPRequestController once some data has been fetched
    func parseGameModes(data: NSData) {
        do {
            //print("[JSON] parsing should start")
            // Turns JSON data into a foundation objects
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            // makes a String:Anyobject list of the value from GameModes : [] pair
            //parse for gamemode
            if let gameModes = json["GameModes"] as? [Payload] {
                //print("[json] gamemodes get \(gameModes)")
                for gameMode in gameModes {
                    //parse for hunts in gamemode
                    let newGameModeObject = GameModeObject(gameDesc: gameMode["description"] as! String, gameTitle: (gameMode["title"] as? String)!, id: (gameMode["id"] as? Int)!, gameModeMedia: gameMode["media"] as! String)
                    if let huntsOfGamemode = gameMode["Hunts"] as? [Payload]{
                        //print("[json] hunts get")
                        for hunt in huntsOfGamemode{
                            let newHunt = HuntObject(title: hunt["title"] as! String, desc: hunt["description"] as! String, winTit: hunt["winTitle"] as! String, winDes: hunt["winDescription"] as! String, huntMedia: hunt["media"] as! String)
                            newHunt.huntID = hunt["id"]!.integerValue
                            //parse for locations in hunt
                            if let locationsList = hunt["Locations"] as? [Payload]{
                                //print("[json] locations get")
                                for locationn in locationsList{
                                    let newLocation = LocationObject(winTit: locationn["winTitle"]! as! String, windDes: locationn["winDescription"]! as! String, id: locationn["id"]!.integerValue, title: locationn["title"]! as! String, locationMedia: locationn["media"]! as! String)
                                    //parse for single beacon
                                    if let beeconi = locationn["Beacon"] as? [Payload]{
                                        //print("[json] beacon get")
                                        for beecon in beeconi{
                                            let minor = beecon["minor"]!.integerValue
                                            let major = beecon["major"]!.integerValue
                                            let uuid = beecon["uuid"]!
                                            let newBeacon = BeaconObject(beaconmajor: major, beaconminor: minor, beaconuuid: uuid as! String)
                                            newLocation.beacon = newBeacon
                                        }
                                    }
                                    if let clues = locationn["Clues"] as? [Payload]{
                                        var clueTier = 0
                                        for clue in clues{
                                            let newClue = ClueObject(clueTitle: clue["title"] as! String, cluetext: clue["description"] as! String, cluetier: clueTier, clueMedia: clue["media"] as! String)
                                            newLocation.clueList.append(newClue)
                                            clueTier += 1
                                        }
                                    }
                                    newHunt.locationList!.append(newLocation)
                                }
                            }
                            gameControllerSingleton.allHunts.append(newHunt)
                            newGameModeObject.huntList.append(newHunt)
                        }
                    }
                    gameControllerSingleton.allGameModes!.append(newGameModeObject)
                }
            }
            // download images for hunts and gameModes
            httpRequestControllerSingleton.getImagesForGameModes(gameControllerSingleton.allGameModes!)
            httpRequestControllerSingleton.getImagesForHunts(gameControllerSingleton.allHunts)
            
        } catch {
            print(error)
        }
        print("[json] DONE PARSING")
    }
}