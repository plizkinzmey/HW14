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
    @Persisted  var weather: List<WeatherData>
    @Persisted  var main: Main?
}

class Main : Object {
    @Persisted  var temp: Float
}

class WeatherData: Object {
    @Persisted  var icon: String
}

class WeatherOneDayMoscowRealm {
    
    static let shared = WeatherOneDayMoscowRealm()
    private let realm = try! Realm()
    
    func addWeatherOneDayMoscowRealm(data: Data) {
        try! realm.write {
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            realm.create(WeatherOneDayMoscow.self, value: json)
        }
    }
    
    func loadWeatherOneDayMoscowRealm() -> [(id:String, temp:Int, icon:String)] {
 
        let dataRealm = realm.objects(WeatherOneDayMoscow.self).first
        let weatherDataArray = [(id: (dataRealm?._id)!.stringValue, temp: Int(dataRealm!.main!.temp), icon: dataRealm!.weather.first!.icon)]
        print(weatherDataArray)
        return weatherDataArray
    }
}




