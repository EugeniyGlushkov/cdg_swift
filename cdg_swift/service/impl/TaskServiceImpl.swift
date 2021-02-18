//
//  TaskArrayServiceImpl.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import Foundation

class TaskServiceImpl: TaskService {
    
    init(withRepository repository: TaskRepository) {
        self.repository = repository
    }
    
    private let repository: TaskRepository
    
    func add(text: String) {
        print("Add text\(text)")
        repository.add(text: text)
    }
    
    func remove(byId id: Int) {
        print("Remove id: \(id)")
        repository.remove(byId: id)
    }
    
    func update(byId id: Int, newText: String) {
        print("Update index: \(id), text: \"\(newText)\"")
        repository.update(byId: id, newText: newText)
    }
    
    func get(byId id: Int) -> Task? {
        print("Get index: \(id)")
        return repository.get(byId: id)
    }
    
    func getAll() -> [Task] {
        repository.getAll()
    }
    
    func getCount() -> Int {
        return repository.getAll().count
    }
}
