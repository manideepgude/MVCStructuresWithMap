//
//  Offlinedata+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by MAC BOOK on 16/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//
//

import Foundation
import CoreData


extension Offlinedata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Offlinedata> {
        return NSFetchRequest<Offlinedata>(entityName: "Offlinedata")
    }

    @NSManaged public var images: String?

}
