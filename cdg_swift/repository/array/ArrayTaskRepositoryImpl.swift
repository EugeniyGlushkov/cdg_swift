//
//  ArrayTaskRepositoryImpl.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation
import CoreData

class ArrayTaskRepositoryImpl: TaskRepositoryProtocol {
    private init() {}
    
    private var repository: [Task] = []
    private var helper =  CoreDataHelper()
    
    private static let instance = ArrayTaskRepositoryImpl()
    
    public static func getInstance() -> ArrayTaskRepositoryImpl {
        return instance
    }
    
    func add(text: String) {
        let newTask = Task(context: helper.context)
        newTask.id = Int64(getNewId())
        newTask.text = text
        repository.append(newTask)
    }
    
    func remove(byId id: Int) {
        repository = repository.filter{
            return $0.id != id
        }
    }
    
    func update(byId id: Int, newText: String) {
        repository.forEach {
            if $0.id == id {
                $0.text = newText
            }
        }
    }
    
    func get(byId id: Int) -> Task? {
        let tasks = repository.filter {
            return $0.id == id
        }
        
        return tasks.isEmpty ? nil : tasks[0]
    }
    
    func getAll() -> [Task] {
        return repository
    }
}
