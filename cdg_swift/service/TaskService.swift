//
//  TaskService.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import Foundation

protocol TaskService {
    func add(text: String) -> Task
    
    func remove(byIndex index: Int)
    
    func update(byIndex index: Int, newText: String)
    
    func get(byIndex index: Int) -> Task
    
    func getCount() -> Int
}
