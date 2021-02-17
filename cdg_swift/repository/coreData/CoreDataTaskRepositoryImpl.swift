//
//  CreDataTaskRepositoryImpl.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation

class CoreDataTaskRepositoryImpl: TaskRepository {
    func add(text: String) -> Task {
        return Task()
    }
    
    func remove(byIndex index: Int) {
        
    }
    
    func update(byIndex index: Int, newText: String) {
        
    }
    
    func get(byIndex index: Int) -> Task {
        return Task()
    }
    
    func getCount() -> Int {
        return 0
    }
    
    func getAll() -> [Task] {
        return []
    }
}
