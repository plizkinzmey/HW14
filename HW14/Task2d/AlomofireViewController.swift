//
//  AlomofireViewController.swift
//  HW12
//
//  Created by Aleksandr Babkin on 26.03.2021.
//

import UIKit

import Alamofire


class AlomofireViewController: UIViewController {
    
    @IBOutlet weak var alamofireWeatherImageView: UIImageView!
    @IBOutlet weak var alamofireWeatherLabel: UILabel!
    @IBOutlet weak var alomofireWeatherTableView: UITableView!
    @IBOutlet weak var header: UILabel!
    
    var weatherOneDayResultCache = WeatherOneDayMoscowRealm.shared.loadWeatherOneDayMoscowRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if weatherOneDayResultCache.isEmpty == false {
            alamofireWeatherLabel.text = "\(weatherOneDayResultCache.first?.temp ?? 00)"
            header.text = "Погода в Москве (Кеш)"
            if let iconUrl = URL(string: "https://openweathermap.org/img/w/\(weatherOneDayResultCache.first!.icon).png") {
                if let data = try? Data(contentsOf: iconUrl) {
                    DispatchQueue.main.async {
                        self.alamofireWeatherImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            getWeatherOneDayMoscow()
            getWeatherSevenDaysMoscow()
            self.weatherOneDayResultCache = WeatherOneDayMoscowRealm.shared.loadWeatherOneDayMoscowRealm()
            self.header.text = "Текущая погода в Москве"
            self.alamofireWeatherLabel.text = "\(self.weatherOneDayResultCache.first?.temp ?? 00)"
            if let iconUrl = URL(string: "https://openweathermap.org/img/w/\(self.weatherOneDayResultCache.first!.icon).png") {
                if let data = try? Data(contentsOf: iconUrl) {
                    DispatchQueue.main.async {
                        self.alamofireWeatherImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
        
        //        getWeatherMoscow7Days {(MainWeatherDataMoscow7Days) in
        //            self.mainWeatherDataMoscow7Days = MainWeatherDataMoscow7Days
        //            self.alomofireWeatherTableView.reloadData()
        //        }
    }
    
    //    func getWeatherMoscow1DayAlamofire(completion: @escaping (MainWeatherDataMoscow1Day) -> Void) {
    //
    //        let seconds = 2.0
    //        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    //            AF.request("https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&appid=be31cc90c56427be4c90f847549a55a2").responseData {
    //                response in
    //                switch response.result {
    //                case let .success(value):
    //                    DispatchQueue.main.async {
    //                        do {
    //                            let mainWeatherData = try JSONDecoder().decode(MainWeatherDataMoscow1Day.self, from: value)
    //                            completion(mainWeatherData)
    //                            if self.weather1DayRealmData.isEmpty {
    //                                PersistanceRealm.shared.addWeather1Day(weatherData: mainWeatherData)
    //                            } else {
    //                                PersistanceRealm.shared.updateWeather1Day(id: self.weather1DayRealmData[0].id, weatherData: mainWeatherData)
    //                            }
    //
    //                        } catch let error {
    //                            print(error)
    //                        }
    //                    }
    //                case let .failure(error):
    //                    print(error)
    //                }
    //            }
    //        }
    //
    //
    //    }
    
    //    func getWeatherMoscow7Days(completion: @escaping (MainWeatherDataMoscow7Days) -> Void){
    //        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&units=metric&exclude=current,minutely,hourly,alerts&appid=be31cc90c56427be4c90f847549a55a2").validate().responseData {
    //            response in
    //            switch response.result {
    //            case let .success(value):
    //                DispatchQueue.main.async {
    //                    do {
    //                        let mainWeatherDataMoscow7Days = try JSONDecoder().decode(MainWeatherDataMoscow7Days.self, from: value)
    //                        completion(mainWeatherDataMoscow7Days)
    //                        print(mainWeatherDataMoscow7Days)
    //                    } catch let error {
    //                        print(error)
    //                    }
    //                }
    //            case let .failure(error):
    //                print(error)
    //            }
    //        }
    //    }
    
}

extension AlomofireViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return mainWeatherDataMoscow7Days?.daily.count ?? 1000
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlomofireWeatherCell", for: indexPath) as! AlomofireTableViewCell
        //        let weatherInformation = mainWeatherDataMoscow7Days?.daily[indexPath.row]
        //        let date = Date(timeIntervalSince1970: TimeInterval(weatherInformation?.dt ?? 0))
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        let strDate = dateFormatter.string(from: date)
        //        cell.alomofireDateLabel?.text = strDate
        //        cell.alomofireDegreeLabel?.text = "\(Int(weatherInformation?.temp?.day ?? 000))℃"
        return cell
    }
}
