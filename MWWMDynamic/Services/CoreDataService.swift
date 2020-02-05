//
//  CoreDataService.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    func getManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchArray(entityName: String, predicate: NSPredicate? = nil, compoundPredicate: NSCompoundPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [NSManagedObject]? {
        guard let managedContext = getManagedContext() else {
            return nil
        }
        
        var resultArray : [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        if let compoundPredicate = compoundPredicate {
            fetchRequest.predicate = compoundPredicate
        }
        
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        do {
            resultArray = try managedContext.fetch(fetchRequest)
            return resultArray
        } catch let error as NSError {
            throw error
        }
    }
    
    func deleteLocation(entity: NSManagedObject) {
        do {
            guard let managedContext = getManagedContext() else {
                throw NSError()
            }
            managedContext.delete(entity)
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
}
