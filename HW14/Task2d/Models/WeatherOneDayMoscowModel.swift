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
    
    func defaultModel() {
        let weatherOneDayMoscow = realm.objects(WeatherOneDayMoscow.self).first
        let weatherSevenDaysMoscow = realm.objects(WeatherSevenDaysMoscow.self).first
        if weatherOneDayMoscow == nil  || weatherSevenDaysMoscow == nil  {
            try! realm.write {
                let weatherOneDayMoscow = WeatherOneDayMoscow()
                let weather = Weather()
                weather.icon = "02n"
                let main = Main()
                main.temp = 0
                weatherOneDayMoscow.main = main
                weatherOneDayMoscow.weather.append(weather)
                
                let weatherSevenDaysMoscow = WeatherSevenDaysMoscow()
                let daily = Daily()
                daily.dt = 0
                let temp = Temp()
                temp.day = 0
                daily.temp = temp
                weatherSevenDaysMoscow.daily.append(daily)
              
                
                realm.add(weatherOneDayMoscow)
                realm.add(weatherSevenDaysMoscow)
                print(weatherOneDayMoscow)
                print(weatherSevenDaysMoscow)
            }
        }
    }
    
    func addWeatherOneDayMoscowRealm(data: Data) {
        try! realm.write {
            //            realm.delete(realm.objects(WeatherOneDayMoscow.self))
            //            realm.delete(realm.objects(Main.self))
            //            realm.delete(realm.objects(Weather.self))
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            realm.create(WeatherOneDayMoscow.self, value: json)
        }
    }
    
    func loadWeatherOneDayMoscowRealm() -> WeatherOneDayMoscow {
        let dataRealm = realm.objects(WeatherOneDayMoscow.self).last
//        let weatherDataArray = [(id: (dataRealm?._id)!.stringValue, temp: Int(dataRealm!.main!.temp), icon: dataRealm!.weather.first!.icon)]
        return dataRealm!
    }
}


