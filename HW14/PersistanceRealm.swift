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
    
    func addTask(name: String) {
        let task = Task()
        task.name = name
        task.taskId = String(PersistanceRealm.shared.realm.objects(Task.self).count + 1)
        try! realm.write {
            realm.add(task)
        }
        
  
    }
    
//    func printTasks() {
//        let allTasks = realm.objects(Task.self)
//        for task in allTasks {
//        }
//    }
    
    func loadTasks() -> [(String, String)] {
        var tasks = [(String, String)]()
        for task in realm.objects(Task.self) {
            tasks.append((task.name, task.taskId))
        }
        return tasks
    }
    
    func removeTask(id: String) {
        let task = realm.object(ofType: Task.self, forPrimaryKey: id)!
        try! realm.write {
            realm.delete(task)
        }
    }
}
