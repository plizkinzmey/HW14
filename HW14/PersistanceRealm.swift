import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var taskId = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var staus = ""
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}

class PersistanceRealm {
    static let shared = PersistanceRealm ()
    
    private let realm = try! Realm()
    
    func loadTasks() -> [(String, String, String)] {
        var tasks = [(String, String, String)]()
        for task in realm.objects(Task.self) {
            tasks.append((task.name, task.taskId, task.staus))
        }
        return tasks
    }
    
    func addTask(name: String) {
        let task = Task()
        task.name = name
        task.staus = "unDone"
        try! realm.write {
            realm.add(task)
        }
       // print(task)
    }
    
    func updateTask (taskId: String) {
        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)!
        try! realm.write {
            task.staus = "Done"
        }
        print(task)
    }
    
    func removeTask(taskId: String) {
        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)!
        try! realm.write {
            realm.delete(task)
        }
    }
}
