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
   // var url: String = "http://23.227.190.85:8080/webApp/path/generic/getGamemodesJson"
    var url: String = "http://23.227.190.85:8080/webApp/path/generic/getAll"
    
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
    
    func downloadImage(url: NSURL) -> AnyObject?{
        var returnImage: AnyObject?
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                returnImage = data
            }
        }
    return returnImage
    }
    
    
}