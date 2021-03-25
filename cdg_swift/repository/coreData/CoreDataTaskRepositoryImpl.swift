//
//  CreDataTaskRepositoryImpl.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation
import CoreData

class CoreDataTaskRepositoryImpl: TaskRepositoryProtocol {
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
        
        newTask.id = Int64(getNewRandomId())
        newTask.text = text
        saveContext()
    }
    
    func remove(byId id: Int) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "any id = \(id)")
        
        do {
            let tasks = try helper.context.fetch(fetchRequest)
            let taskToDelete = tasks[0]
            helper.context.delete(taskToDelete)
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func update(byId id: Int, newText: String) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        guard let taskToUpdate = get(byId: id, fetchRequest: fetchRequest) else {
            return
        }
        
        taskToUpdate.setValue(newText, forKey: "text")
        saveContext()
    }
    
    func get(byId id: Int) -> Task? {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return get(byId: id, fetchRequest: fetchRequest)
    }
    
    private func get(byId id: Int, fetchRequest: NSFetchRequest<Task>) -> Task? {
        fetchRequest.predicate = NSPredicate(format: "any id = \(id)")
        var tasks: [Task]
        
        do {
            tasks = try helper.context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return tasks.isEmpty ? nil : tasks[0]
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
