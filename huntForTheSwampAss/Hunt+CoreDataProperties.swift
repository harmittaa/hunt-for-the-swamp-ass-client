//
//  Hunt+CoreDataProperties.swift
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

extension Hunt {

    @NSManaged var huntDescription: String?
    @NSManaged var huntEndDate: NSDate?
    @NSManaged var huntStartDate: NSDate?
    @NSManaged var huntThumbnailPath: String?
    @NSManaged var huntTitle: String?
    @NSManaged var completion: Completion?
    @NSManaged var location: NSOrderedSet?

}
