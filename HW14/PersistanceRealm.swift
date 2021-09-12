import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var taskId = UUID().uuidString
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}

class PersistanceRealm {
    static let shared = PersistanceRealm ()
    
    private let realm = try! Realm()
    
    func loadTasks() -> [(String, String)] {
        var tasks = [(String, String)]()
        for task in realm.objects(Task.self) {
            tasks.append((task.name, task.taskId))
        }
        return tasks
    }
    
    func addTask(name: String) {
        let task = Task()
        task.name = name
        try! realm.write {
            realm.add(task)
        }
    }
    
    func removeTask(taskId: String) {
        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)!
        try! realm.write {
            realm.delete(task)
        }
    }
}
