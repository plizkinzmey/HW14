//
//  WeatherOneDayMoscowModel.swift
//  HW14
//
//  Created by Александр Бабкин on 30.10.2021.
//

import RealmSwift
import Foundation
import Alamofire

class WeatherOneDayMoscow: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted  var weather: List<Weather>
    @Persisted  var main: Main?
    
    convenience init(weather: [Weather], main: Main) {
        self.init()
        self.weather.append(objectsIn: weather)
        self.main = main
    }
}

class Main : Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted  var temp: Float
}

class Weather: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted  var icon: String
}

class WeatherOneDayMoscowRealm {
    
    static let shared = WeatherOneDayMoscowRealm()
    private let realm = try! Realm()
    
    func isEmpty() -> Bool {
        if realm.objects(WeatherOneDayMoscow.self).isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func addWeatherOneDayMoscowRealm(data: Data) {
        try! realm.write {
            realm.delete(realm.objects(WeatherOneDayMoscow.self))
            realm.delete(realm.objects(Main.self))
            realm.delete(realm.objects(Weather.self))
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            realm.create(WeatherOneDayMoscow.self, value: json)
        }
    }
    
    func loadWeatherOneDayMoscowRealm() -> [(id:String, temp:Int, icon:String)] {
        
        let dataRealm = realm.objects(WeatherOneDayMoscow.self).first
        let weatherDataArray: [(id:String, temp:Int, icon:String)]?
        weatherDataArray = [(id: (dataRealm?._id)!.stringValue, temp: Int(dataRealm!.main!.temp), icon: dataRealm!.weather.first!.icon)]
        return weatherDataArray!
    }
}


