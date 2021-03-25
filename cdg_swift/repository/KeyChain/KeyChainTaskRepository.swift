//
// Created by evgen on 23.03.2021.
//

import Foundation
import Locksmith

class KeyChainTaskRepository: TaskRepositoryProtocol {
    private init() {
        guard let tasks = getData() else {
            saveData(data: [:], errorMessage: Self.INITIAL_ERROR_MESSAGE)
            return
        }
    }

    private static let instance = KeyChainTaskRepository()

    public static func getInstance() -> KeyChainTaskRepository {
        return instance
    }

    private static let USER_ACCOUNT_NAME = "MyNameUserAcc"
    private static let ADD_ERROR_MESSAGE = "Unable to add data"
    private static let REMOVE_ERROR_MESSAGE = "Unable to remove data"
    private static let UPDATE_ERROR_MESSAGE = "Unable to update data"
    private static let GET_ERROR_MESSAGE = "Unable to get data"
    private static let GET_ALL_ERROR_MESSAGE = "Unable to get all data"
    private static let INITIAL_ERROR_MESSAGE = "Unable to initial"

    private var helper = CoreDataHelper()

    func add(text: String) {
        guard let newTasks = getTasksWithNewElement(newText: text) else {
            print(Self.ADD_ERROR_MESSAGE)
            return
        }

        updateData(data: newTasks, errorMessage: Self.ADD_ERROR_MESSAGE)
    }

    func remove(byId id: Int) {
        guard let tasks = getData() else {
            print(Self.REMOVE_ERROR_MESSAGE)
            return
        }

        let updatedTasks = tasks.filter { task in
            task.key != String(id)
        }

        updateData(data: updatedTasks, errorMessage: Self.REMOVE_ERROR_MESSAGE)
    }

    func update(byId id: Int, newText: String) {
        guard var tasks = getData() else {
            print(Self.UPDATE_ERROR_MESSAGE)
            return
        }

        tasks[String(id)] = newText

        updateData(data: tasks, errorMessage: Self.UPDATE_ERROR_MESSAGE)
    }

    func get(byId id: Int) -> Task? {
        guard var tasks = getData() else {
            print(Self.GET_ERROR_MESSAGE)
            return nil
        }

        guard let task = (tasks.first { key, value in
            return key == String(id)
        }) else {
            return nil
        }

        let taskEntity = Task(context: helper.context)
        taskEntity.id = Int64(id)
        taskEntity.text = task.value as? String

        return taskEntity
    }

    func getAll() -> [Task] {
        guard var tasks = getData() else {
            print(Self.GET_ALL_ERROR_MESSAGE)
            return []
        }

        return tasks.map { key, value in
            let task = Task(context: helper.context)
            task.id = Int64(Int(key)!)
            task.text = value as? String
            return task
        }
        .sorted{ t, t2 in
            return t.id < t2.id
        }
    }

    private func getTasksWithNewElement(newText: String) -> [String: Any]? {
        let stringId = String(getNewId())

        guard var tasks = getData() else {
            return nil
        }

        tasks[stringId] = newText
        return tasks
    }

    private func getData() -> [String: Any]? {
        return Locksmith.loadDataForUserAccount(userAccount: Self.USER_ACCOUNT_NAME)
    }

    private func saveData(data: [String: Any], errorMessage: String) {
        do {
            try Locksmith.saveData(data: data, forUserAccount: Self.USER_ACCOUNT_NAME)
        } catch {
            print(errorMessage)
        }
    }

    private func updateData(data: [String: Any], errorMessage: String) {
        do {
            try Locksmith.updateData(data: data, forUserAccount: Self.USER_ACCOUNT_NAME)
        } catch {
            print(errorMessage)
        }
    }
}
