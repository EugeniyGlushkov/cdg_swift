//
//  TaskArrayServiceImpl.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import Foundation

class TaskServiceImpl: TaskServiceProtocol {
    
    init(withRepository repository: TaskRepositoryProtocol) {
        self.repository = repository
    }
    
    private let repository: TaskRepositoryProtocol
    
    func add(text: String) {
        repository.add(text: text)
    }
    
    func remove(byId id: Int) {
        repository.remove(byId: id)
    }
    
    func update(byId id: Int, newText: String) {
        repository.update(byId: id, newText: newText)
    }
    
    func get(byId id: Int) -> Task? {
        return repository.get(byId: id)
    }
    
    func getAll() -> [Task] {
        repository.getAll()
    }
    
    func getCount() -> Int {
        return repository.getAll().count
    }
}
