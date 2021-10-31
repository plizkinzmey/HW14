//
//  Requests.swift
//  HW14
//
//  Created by Александр Бабкин on 30.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

func getWeatherOneDayMoscow () {
    let url = "https://api.openweathermap.org/data/2.5/weather?"
    let q = "Moscow"
    let units = "metric"
    let appid = "be31cc90c56427be4c90f847549a55a2"
    let param = [
        "q": q,
        "units": units,
        "appid": appid
    ]
    AF.request(url, method: .get, parameters: param).responseData {
        response in
        switch response.result {
        case let .success(value):
            DispatchQueue.main.async {
                WeatherOneDayMoscowRealm.shared.addWeatherOneDayMoscowRealm(data: value)
                print(value)
            }
        case let .failure(error):
            print(error)
        }
    }
}

func getWeatherSevenDaysMoscow () {
    let url = "https://api.openweathermap.org/data/2.5/onecall?"
    let lat = "55.7522"
    let lon = "37.6156"
    let units = "metric"
    let exclude = "current,minutely,hourly,alerts"
    let appid = "be31cc90c56427be4c90f847549a55a2"
    
    let param = [
        "lat": lat,
        "lon": lon,
        "units": units,
        "exclude": exclude,
        "appid": appid
    ]
    AF.request(url, method: .get, parameters: param).responseData {
        response in
        switch response.result {
        case let .success(value):
            DispatchQueue.main.async {
                WeatherSevenDaysMoscowRealm.shared.addWeatherOneDayMoscowRealm(data: value)
            }
        case let .failure(error):
            print(error)
        }
    }
}
