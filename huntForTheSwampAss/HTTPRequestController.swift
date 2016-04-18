//
//  HTTPRequestController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 18.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

let httpRequestControllerSingleton = HTTPRequestController()

class HTTPRequestController {
    var url: String = "http://23.227.190.85:8080/webApp/path/generic/getGamemodesJson"
    
    private init() {
        print("[HTTPRequestController] Singleton created")
    }
    
    func getGameModes() {
        print("[HTTP] getgamemodes called")
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)
        let sessionTask = session.dataTaskWithURL(NSURL(string: url)!, completionHandler: {(data, response, error) -> Void in
            print("[HTTPRequestController] data fetched")
            print(data)
            
            let gameModeParsingOperation = NSBlockOperation(block: {
                let jsonParser = JsonParser()
                jsonParser.parseGameModes(data!)
            })
            
            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount = 1
            queue.addOperation(gameModeParsingOperation)
        })
        sessionTask.resume()
    }
}