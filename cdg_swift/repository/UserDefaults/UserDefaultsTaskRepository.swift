//
// Created by evgen on 22.03.2021.
//

import Foundation
import CoreData

class UserDefaultsKeys {
    static let DATA_TASK_KEY = "DataTask"
}

class UserDefaultsTaskRepository: TaskRepository {
    private init() {
    }

    private var helper =  CoreDataHelper()

    private static let instance = UserDefaultsTaskRepository()

    public static func getInstance() -> UserDefaultsTaskRepository {
        return instance
    }

    let defaults = UserDefaults.standard

    struct DataTask: Codable {
        var id: Int
        var text: String
    }

    var tasks: [DataTask] {
        get {
            guard let data = defaults.value(forKey: UserDefaultsKeys.DATA_TASK_KEY) as? Data else {
                return Array<DataTask>()
            }

            return try! PropertyListDecoder().decode([DataTask].self, from: data)
        }

        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: UserDefaultsKeys.DATA_TASK_KEY)
            }
        }
    }

    func add(text: String) {
        let newDataTask = DataTask(id: getNewId(), text: text)
    }

    func remove(byId id: Int) {
        guard let deletedIndex = (tasks.firstIndex { task in
            return task.id == id
        }) else {
            return
        }

        tasks.remove(at: deletedIndex)
    }

    func update(byId id: Int, newText: String) {
        guard let updatedIndex = (tasks.firstIndex { task in
            return task.id == id
        }) else {
            return
        }

        tasks[updatedIndex].text = newText
    }

    func get(byId id: Int) -> Task? {
        let dataTask = tasks.first{ task in
            task.id == id
        } ?? nil

        guard dataTask == nil else {
            return nil
        }

        let task = Task(context: helper.context)
        task.id = Int64(dataTask!.id)
        task.text = dataTask?.text
        return task
    }

    func getAll() -> [Task] {
        return tasks.map { dataTask in
            let task = Task(context: helper.context)
            task.id = Int64(dataTask.id)
            task.text = dataTask.text
            return task
        }
    }

}
