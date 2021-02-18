//
//  TaskService.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import Foundation

protocol TaskService {
    func add(text: String)
    
    func remove(byId id: Int)
    
    func update(byId id: Int, newText: String)
    
    func get(byId id: Int) -> Task?
    
    func getAll() -> [Task]
    
    func getCount() -> Int
}
