//
//  HTTPRequestController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 18.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

// for getting data from the back end

import Foundation
import UIKit
let httpRequestControllerSingleton = HTTPRequestController()

class HTTPRequestController {
    var url: String = "http://23.227.190.85:8080/webApp/path/generic/getAll"
    var splashScreen: SplashScreenViewController?
    private init() {
        print("[HTTPRequestController] Singleton created")
    }
    
    func getGameModes() {
        print("[HTTP] getgamemodes called")
        // creates a default config
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)
        // create a NSOperation task with the correct URL, and in the codeblock define what is to be done
        // with the data that is retrieved
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: url)!, completionHandler: {(data, response, error) -> Void in
            print("[HTTPRequestController] data fetched")
            let gameModeParsingOperation = NSBlockOperation(block: {
                let jsonParser = JsonParser()
                // call jsonParser to parse the data
                jsonParser.parseGameModes(data!)
            })
            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount = 1
            queue.addOperation(gameModeParsingOperation)
        })
        // start the sessiontask
        sessionTask.resume()
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    // gets images for the selected hunt's locations
    func getImagesForLocations(locationList: [LocationObject]) {
        print("[HTTP] getting images for locations!")
        let downloadConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: downloadConfig)
        for location in locationList {
            let downloadTask = session.dataTaskWithURL(NSURL(string: location.locationMedia)!, completionHandler: {(data, response, error) -> Void in
                let addImageToLocations = NSBlockOperation(block: {
                    // set the image for the location
                    location.setImage(UIImage(data: data!)!)
                    print("[HTTP] setting image for clue \(location.locationTitle)")
                })
                let queue = NSOperationQueue()
                queue.maxConcurrentOperationCount = 1
                queue.addOperation(addImageToLocations)
            })
            // start the downloadTask
            downloadTask.resume()
        }
    }
    
    
    // gets images for the selected hunt's locations clues
    func getImages(locationList: [LocationObject]) {
        print("[HTTP] getting images for all clues!")
        let downloadConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: downloadConfig)
        for location in locationList {
            for clue in location.clueList {
                // check if the clue's media has a link
                if clue.clueMedia.rangeOfString("http") != nil {
                    // create download task and place it in the nsoperationqueue
                    let downloadTask = session.dataTaskWithURL(NSURL(string: clue.clueMedia)!, completionHandler: {(data, response, error) -> Void in
                        let addImageToClues = NSBlockOperation(block: {
                            // set the image for the clue
                            clue.setImage(UIImage(data: data!)!)
                            print("[HTTP] setting image for clue \(clue.clueTitle)")
                        })
                        let queue = NSOperationQueue()
                        queue.maxConcurrentOperationCount = 1
                        queue.addOperation(addImageToClues)
                    })
                    // start the downloadTask
                    downloadTask.resume()
                } else {
                    // if the clue doesn't have an image, set the boolean as false
                    clue.setImageBool(false)
                }
            }
        }
    }
    
    // gets images for the selected hunt's locations clues
    func getImagesForHunts(huntList: [HuntObject]) {
        print("[HTTP] getting images for all hunts!")
        let downloadConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: downloadConfig)
        for hunt in huntList {
            let downloadTask = session.dataTaskWithURL(NSURL(string: hunt.huntMedia)!, completionHandler: {(data, response, error) -> Void in
                let addImageToHunt = NSBlockOperation(block: {
                    // set the image for the clue
                    hunt.setImage(UIImage(data: data!)!)
                    print("[HTTP] setting image for Hunt \(hunt.huntTitle)")
                })
                let queue = NSOperationQueue()
                queue.maxConcurrentOperationCount = 1
                queue.addOperation(addImageToHunt)
            })
            // start the downloadTask
            downloadTask.resume()
        }
    }
    
    // gets images for the gameModes
    func getImagesForGameModes(gameModeList: [GameModeObject]) {
        print("[HTTP] getting images for all GameModes!")
        let downloadConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: downloadConfig)
        for gameMode in gameModeList {
            let downloadTask = session.dataTaskWithURL(NSURL(string: gameMode.gameModeMedia)!, completionHandler: {(data, response, error) -> Void in
                let addImageToGameMode = NSBlockOperation(block: {
                    // set the image for the clue
                    gameMode.setImage(UIImage(data: data!)!)
                    print("[HTTP] setting image for GameMode \(gameMode.gameModeTitle)")
                })
                let queue = NSOperationQueue()
                queue.maxConcurrentOperationCount = 1
                queue.addOperation(addImageToGameMode)
            })
            // start the downloadTask
            downloadTask.resume()
            print("[HTTP] !!MOVETOGAMESCREEN!!")
            
        }
        splashScreen!.moveToGameScreen()
    }
    
    func registerAsSplashScreen(splash: SplashScreenViewController){
        self.splashScreen = splash
    }
    
    // get image from url
    func getImageFromUrl(url:String) -> UIImage {
        print("[HTTP Image] getting an image from url!")
        let imageUrl = NSURL(string: url)
        let imageData = NSData(contentsOfURL: imageUrl!)
        return UIImage(data: imageData!)!
    }
}