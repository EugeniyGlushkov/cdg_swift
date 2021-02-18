//
//  CreDataTaskRepositoryImpl.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation
import CoreData

class CoreDataTaskRepositoryImpl: TaskRepository {
    private init() {}
    
    private var helper = CoreDataHelper()
    
    private static let instance = CoreDataTaskRepositoryImpl()
    
    public static func getInstance() -> CoreDataTaskRepositoryImpl {
        return instance
    }
    
    func add(text: String) {
        guard let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: helper.context) as? Task else {
            return
        }
        
        newTask.id = Int64(getNewId())
        newTask.text = text
        saveContext()
    }
    
    func remove(byId id: Int) {
        
    }
    
    func update(byId id: Int, newText: String) {
        
    }
    
    func get(byId id: Int) -> Task? {
        return Task()
    }
    
    func getCount() -> Int {
        return getAll().count
    }
    
    func getAll() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        var tasks: [Task]
        
        do {
            tasks = try helper.context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return tasks
    }
    
    private func saveContext() {
        if helper.context.hasChanges {
            do {
                try helper.context.save()
            } catch {
                helper.context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
