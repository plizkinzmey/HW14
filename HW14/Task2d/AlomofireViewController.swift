//
//  AlomofireViewController.swift
//  HW12
//
//  Created by Aleksandr Babkin on 26.03.2021.
//

import UIKit
import RealmSwift

class AlomofireViewController: UIViewController {
    
    @IBOutlet weak var alamofireWeatherImageView: UIImageView!
    @IBOutlet weak var alamofireWeatherLabel: UILabel!
    @IBOutlet weak var alomofireWeatherTableView: UITableView!
    @IBOutlet weak var header: UILabel!
    
    var weatherOneDayResultCache: WeatherOneDayMoscow?
    var weatherSevenDaysResultCache: WeatherSevenDaysMoscow?
    
    
    override func viewDidLoad() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        super.viewDidLoad()
        
        WeatherOneDayMoscowRealm.shared.defaultModel()
        
        presentData()
        
        getWeatherOneDayMoscow()
        getWeatherSevenDaysMoscow()
        
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.presentData()
            self.alomofireWeatherTableView.reloadData()
        }
    }
    
    func presentData() {
        self.weatherOneDayResultCache = WeatherOneDayMoscowRealm.shared.loadWeatherOneDayMoscowRealm()
        self.weatherSevenDaysResultCache = WeatherSevenDaysMoscowRealm.shared.loadWeatherSevenDayMoscowRealm()
        let currentDateTime = Date()
        print(currentDateTime)
        alamofireWeatherLabel.text = "\(String(describing: Int(weatherOneDayResultCache!.main!.temp)))"
        if let iconUrl = URL(string: "https://openweathermap.org/img/w/\(String(describing: weatherOneDayResultCache!.weather.first!.icon)).png") {
            if let data = try? Data(contentsOf: iconUrl) {
                DispatchQueue.main.async {
                    self.alamofireWeatherImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

extension AlomofireViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherSevenDaysResultCache?.daily.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlomofireWeatherCell", for: indexPath) as! AlomofireTableViewCell
        if weatherSevenDaysResultCache != nil {
            let weatherInformation = weatherSevenDaysResultCache?.daily[indexPath.row]
            let date = Date(timeIntervalSince1970: TimeInterval(weatherInformation!.dt))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let strDate = dateFormatter.string(from: date)
            cell.alomofireDateLabel?.text = strDate
            cell.alomofireDegreeLabel?.text = "\(Int(weatherInformation?.temp?.day ?? 000))℃"
        }
        return cell
    }
}
