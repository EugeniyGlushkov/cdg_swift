//
//  TaskRepository.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation

protocol TaskRepository {
    func add(text: String) -> Task
    
    func remove(byIndex index: Int)
    
    func update(byIndex index: Int, newText: String)
    
    func get(byIndex index: Int) -> Task
    
    func getAll() -> [Task]
}

extension TaskRepository {
    func getNewId() -> Int {
        let newId = Int.random(in: 1...10000000000)
        return isIdExist(newId) ? getNewId() : newId
    }
    
    private func isIdExist(_ id: Int) -> Bool {
        getAll().contains{$0.id == id}
    }
}
