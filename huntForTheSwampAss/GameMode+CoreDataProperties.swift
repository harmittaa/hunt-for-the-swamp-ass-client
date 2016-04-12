//
//  GameMode+CoreDataProperties.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 8.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GameMode {

    @NSManaged var gameModeDescription: String?
    @NSManaged var gameModeThumbnailPath: String?
    @NSManaged var gameModeTitle: String?
    @NSManaged var hunt: NSSet?

}