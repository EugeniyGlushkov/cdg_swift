//
//  ArrayTaskRepositoryImpl.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation
import CoreData

class ArrayTaskRepositoryImpl: TaskRepository {
    private init() {}
    
    private var repository: [Task] = []
    private var context: NSManagedObjectContext = { return AppDelegate.persistentContainer.viewContext }()
    
    private static let instance = ArrayTaskRepositoryImpl()
    
    public static func getInstance() -> ArrayTaskRepositoryImpl {
        return instance
    }
    
    func add(text: String) -> Task {
        let newTask = Task(context: context)
        newTask.text = text
        let newId = getNewId()
        newTask.id = Int64(newId)
        repository.append(newTask)
        return newTask
    }
    
    func remove(byIndex index: Int) {
        repository.remove(at: index)
    }
    
    func update(byIndex index: Int, newText: String) {        
        repository[index].text = newText
    }
    
    func get(byIndex index: Int) -> Task {
        return repository[index]
    }
    
    func getAll() -> [Task] {
        return repository.map{
            task in
            return task
        }
    }
}
