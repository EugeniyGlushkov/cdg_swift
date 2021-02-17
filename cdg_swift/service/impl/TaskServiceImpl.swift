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
    
    func add(text: String) -> Task {
        print("Add text\(text)")
        return repository.add(text: text)
    }
    
    func remove(byIndex index: Int) {
        print("Remove id: \(index)")
        repository.remove(byIndex: index)
    }
    
    func update(byIndex index: Int, newText: String) {
        print("Update index: \(index), text: \"\(newText)\"")
        guard index < getCount() else { return }
        repository.update(byIndex: index, newText: newText)
    }
    
    func get(byIndex index: Int) -> Task {
        print("Get index: \(index)")
        return repository.get(byIndex: index)
    }
    
    func getCount() -> Int {
        return repository.getAll().count
    }
}
