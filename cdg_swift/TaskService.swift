//
//  TaskService.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import Foundation

class TaskService {
    private init() {}
    
    static let instance = TaskService()
    
    var tasks: [Task] = []
    
    func add(text: String) {
        tasks.append(Task(id: getNewId(), text: text))
    }
    
    func remove(byIndex index: Int) {
        tasks.remove(at: index)
    }
    
    func update(byIndex index: Int, newText: String) {
        guard index < tasks.count else { return }
        
        tasks[index].text = newText
    }
    
    func get(byIndex index: Int) -> Task {
        return tasks[index]
    }
    
    func getCount() -> Int {
        return tasks.count
    }
    
    private func getNewId() -> Int {
        let newId = Int.random(in: 1...10000000000)
        return isIdExist(newId) ? getNewId() : newId
    }
    
    private func isIdExist(_ id: Int) -> Bool {
        tasks.contains{$0.id == id}
    }
}
