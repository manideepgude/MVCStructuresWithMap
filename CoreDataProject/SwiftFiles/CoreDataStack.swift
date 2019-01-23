//
//  CoreDataStack.swift
//  PaytmSwift
//
//  Created by CYKUL on 29/08/18.
//  Copyright © 2018 Sachtech Solutions Pvt. Ltd. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class CoreDataStack
{
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataProject")   
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    class func saveContext ()
    {
        let context = persistentContainer.viewContext
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error")
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
