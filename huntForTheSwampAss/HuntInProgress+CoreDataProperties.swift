//
//  HuntInProgress+CoreDataProperties.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 29.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HuntInProgress {

    @NSManaged var clueProgress: NSNumber?
    @NSManaged var huntId: NSNumber?
    @NSManaged var locationProgress: NSNumber?
    @NSManaged var startDate: NSDate?

}
