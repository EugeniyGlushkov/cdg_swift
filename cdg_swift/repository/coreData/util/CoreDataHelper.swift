//
//  CoreDataHelper.swift
//  cdg_swift
//
//  Created by evgen on 17.02.2021.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    let stack = CoreDataStack(modelName: "cdg_swift")!
    var context:NSManagedObjectContext
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            executeSearch()
        }
    }
    
    init() {
        context = stack.context
    }
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}

