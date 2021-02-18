//
//  Task+CoreDataClass.swift
//  cdg_swift
//
//  Created by evgen on 17.02.2021.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    convenience init(id: Int64, text: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Task", in: context) {
            self.init(entity: ent, insertInto: context)
            self.id = id
            self.text = text
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
