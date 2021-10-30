//
//  WeatherSevenDaysMoscowModel.swift
//  HW14
//
//  Created by Александр Бабкин on 30.10.2021.
//

import Foundation
import RealmSwift


// MARK: - Welcome
class WeatherSevenDaysMoscow: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var daily: List<Daily>
    convenience init(daily: [Daily]) {
            self.init()
            self.daily.append(objectsIn: daily)
        }
}

// MARK: - Daily
class Daily: Object {
    @Persisted var dt: Int = 0
    @Persisted var temp: Temp?
}

// MARK: - Temp
class Temp:  Object {
    @Persisted var day: Double
}

class WeatherSevenDaysMoscowRealm {
    
    static let shared = WeatherSevenDaysMoscowRealm()
    private let realm = try! Realm()
    
    func addWeatherOneDayMoscowRealm(data: Data) {
        try! realm.write {
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            realm.create(WeatherSevenDaysMoscow.self, value: json)
        }
    }
}
