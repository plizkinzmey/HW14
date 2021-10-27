import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var taskId = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var staus = false
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}

class Weather1Day: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var temp: Float = 0
    @objc dynamic var icon = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PersistanceRealm {
    static let shared = PersistanceRealm ()
    
    private let realm = try! Realm()
    
    func loadTasks() -> [(String, String, Bool)] {
        var tasks = [(String, String, Bool)]()
        for task in realm.objects(Task.self) {
            tasks.append((task.name, task.taskId, task.staus))
        }
        return tasks
    }
    
    func addTask(name: String) {
        let task = Task()
        task.name = name
        task.staus = false
        try! realm.write {
            realm.add(task)
        }
    }
    
    func updateTask (taskId: String) {
        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)!
        try! realm.write {
            task.staus = !(task.staus)
        }
    }
    
    func removeTask(taskId: String) {
        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)!
        try! realm.write {
            realm.delete(task)
        }
    }
    
    func addWeather1Day (weatherData: MainWeatherDataMoscow1Day) {
        let weather = Weather1Day()
        weather.temp = weatherData.main?.temp ?? 0
        weather.icon = weatherData.weather[0]?.icon ?? ""
        try! realm.write {
            realm.add(weather)
        }
    }
    
    func updateWeather1Day (id: String, weatherData: MainWeatherDataMoscow1Day) {
        let weather = realm.object(ofType: Weather1Day.self, forPrimaryKey: id)!
        try! realm.write {
            weather.temp = weatherData.main?.temp ?? 0
            weather.icon = weatherData.weather[0]?.icon ?? ""
        }
    }
    
    func loadWeather1Day() -> [(id: String, temp: Float, image: String)] {
        var weathers = [(id: String, temp: Float, image: String)]()
        for weatherData in realm.objects(Weather1Day.self) {
            weathers.append((weatherData.id, weatherData.temp, weatherData.icon))
        }
        return weathers
    }
    
    func addWeather7Days(weather7DaysJSON: MainWeatherDataMoscow7Days) {
    }
}
