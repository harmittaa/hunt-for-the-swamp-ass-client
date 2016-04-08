//
//  Location+CoreDataProperties.swift
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

extension Location {

    @NSManaged var locationTitle: String?
    @NSManaged var beacon: Beacon?
    @NSManaged var clue: NSSet?
    @NSManaged var completion: Completion?

}
