//
//  TaskRepositoryProtocol.swift
//  cdg_swift
//
//  Created by evgen on 16.02.2021.
//

import Foundation

protocol TaskRepositoryProtocol {
    func add(text: String)
    
    func remove(byId id: Int)
    
    func update(byId id: Int, newText: String)
    
    func get(byId id: Int) -> Task?
    
    func getAll() -> [Task]
}

extension TaskRepositoryProtocol {
    func getNewId() -> Int {
        return 0
        //getAll()
    }

    func getNewRandomId() -> Int {
        let newId = Int.random(in: 1...10000000000)
        return isIdExist(newId) ? getNewRandomId() : newId
    }
    
    private func isIdExist(_ id: Int) -> Bool {
        getAll().contains{$0.id == id}
    }
}
