//
//  TaskArrayServiceImpl.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import Foundation

class TaskArrayServiceImpl: TaskService {
    private init() {}
    
    private static let instance = TaskArrayServiceImpl()
    
    static func getInstance() -> TaskArrayServiceImpl {
        return instance
    }
    
    private var tasks: [Task] = []
    
    func add(text: String) -> Task {
        let newTask = Task(id: getNewId(), text: text)
        tasks.append(newTask)
        return newTask
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
