//
//  LoggedUser+CoreDataProperties.swift
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

extension LoggedUser {

    @NSManaged var userDesc: String?
    @NSManaged var userId: NSNumber?
    @NSManaged var userImagePath: String?
    @NSManaged var userName: String?

}
