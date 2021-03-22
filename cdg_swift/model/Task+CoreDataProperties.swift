//
//  Task+CoreDataProperties.swift
//  cdg_swift
//
//  Created by evgen on 17.02.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: Int64
    @NSManaged public var text: String?

}

extension Task: Identifiable {

}
