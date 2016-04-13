//
//  viewObeserverProtocol.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

protocol ViewObserverProtocol{
    func registerAsObserver()
    func receiveNotification()
}