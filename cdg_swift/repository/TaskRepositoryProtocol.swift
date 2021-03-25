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
    private var START_ID: Int {
        return 10000
    }

    private var RANDOM_ID_INTERVAL: ClosedRange<Int> {
        return 1...10000000000
    }

    func getNewId() -> Int {
        let maxId = getAll().reduce(START_ID) { result, task in
            return result > Int(task.id) ? result : Int(task.id)
        }

        return maxId + 1
    }

    func getNewRandomId() -> Int {
        let newId = Int.random(in: RANDOM_ID_INTERVAL)
        return isIdExist(newId) ? getNewRandomId() : newId
    }

    private func isIdExist(_ id: Int) -> Bool {
        getAll().contains {
            $0.id == id
        }
    }
}
