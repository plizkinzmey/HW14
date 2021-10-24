//
//  StandartViewController.swift
//  HW12
//
//  Created by Aleksandr Babkin on 23.03.2021.
//

import UIKit

struct MainWeatherDataMoscow1Day: Decodable {
    var weather: [weather?]
    var main: main?
}

struct main : Decodable {
    var temp: Float
}

struct weather: Decodable {
    var icon: String
}

struct MainWeatherDataMoscow7Days: Decodable {
    var daily: [daily?]
}

struct MainWeatherDataMoscow5Days: Decodable {
    var list: [list?]
}

struct list: Decodable {
    var dt: Int
    var main: main
    var dt_txt: String
}

struct daily: Decodable {
    var dt: Int
    var temp: temp?
}

struct temp: Decodable {
    var day: Float
}


class StandartViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var standartWeatherLabel: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var mainWeatherDataMoscow7Days: MainWeatherDataMoscow7Days? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherMoscow1Day()
        getWeatherMoscow7Days {(MainWeatherDataMoscow7Days) in
            self.mainWeatherDataMoscow7Days = MainWeatherDataMoscow7Days
            self.weatherTableView.reloadData()
          

        }
        
    }
    
    func getWeatherMoscow1Day() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&appid=be31cc90c56427be4c90f847549a55a2")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let mainWeatherData = try JSONDecoder().decode(MainWeatherDataMoscow1Day.self, from: data)
                        let degreeInt = Int(mainWeatherData.main?.temp ?? -99)
                        self.standartWeatherLabel.text = "\(degreeInt)℃"
                        let weatherIcon = String(mainWeatherData.weather[0]?.icon ?? "noimage")
                        if let iconUrl = URL(string: "https://openweathermap.org/img/w/\(weatherIcon).png") {
                            let task = URLSession.shared.dataTask(with: iconUrl, completionHandler: { data, response, error in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        self.weatherImageView.image = UIImage(data: data)
                                    }
                                }
                            })
                            task.resume()
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func getWeatherMoscow7Days(completion: @escaping (MainWeatherDataMoscow7Days) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&units=metric&exclude=current,minutely,hourly,alerts&appid=be31cc90c56427be4c90f847549a55a2")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let mainWeatherDataMoscow7Days = try JSONDecoder().decode(MainWeatherDataMoscow7Days.self, from: data)
                        completion(mainWeatherDataMoscow7Days)
                    } catch let error {
                        print(error)
                    }
                }
                
            }
        }
        
        task.resume()
    }
}

extension StandartViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainWeatherDataMoscow7Days?.daily.count ?? 1000
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        let weatherInformation = mainWeatherDataMoscow7Days?.daily[indexPath.row]
        let date = Date(timeIntervalSince1970: TimeInterval(weatherInformation?.dt ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        cell.dateWeatherLabel?.text = strDate
        cell.degreeWeatherLabel?.text = "\(Int(weatherInformation?.temp?.day ?? 000))℃"
        return cell
    }
}
