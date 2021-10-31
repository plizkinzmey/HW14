//
//  AlomofireViewController.swift
//  HW12
//
//  Created by Aleksandr Babkin on 26.03.2021.
//

import UIKit

class AlomofireViewController: UIViewController {
    
    @IBOutlet weak var alamofireWeatherImageView: UIImageView!
    @IBOutlet weak var alamofireWeatherLabel: UILabel!
    @IBOutlet weak var alomofireWeatherTableView: UITableView!
    @IBOutlet weak var header: UILabel!
    
    var weatherOneDayResultCache:[(id:String, temp:Int, icon:String)]?
    var weatherSevenDaysResultCache: WeatherSevenDaysMoscow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WeatherOneDayMoscowRealm.shared.isEmpty() == true {
            getWeatherOneDayMoscow()
            getWeatherSevenDaysMoscow()
        }
        
        presentData()
        getWeatherOneDayMoscow()
        getWeatherSevenDaysMoscow()
        
        let seconds = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.presentData()
            self.alomofireWeatherTableView.reloadData()
        }
    }
    
    func presentData() {
        self.weatherOneDayResultCache = WeatherOneDayMoscowRealm.shared.loadWeatherOneDayMoscowRealm()
        self.weatherSevenDaysResultCache = WeatherSevenDaysMoscowRealm.shared.loadWeatherSevenDayMoscowRealm()
        print("Update")
        let currentDateTime = Date()
        print(currentDateTime)
        alamofireWeatherLabel.text = "\(weatherOneDayResultCache?.first?.temp ?? 00)"
        if let iconUrl = URL(string: "https://openweathermap.org/img/w/\(String(describing: weatherOneDayResultCache!.first!.icon)).png") {
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
        let weatherInformation = weatherSevenDaysResultCache?.daily[indexPath.row]
        let date = Date(timeIntervalSince1970: TimeInterval(weatherInformation!.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        cell.alomofireDateLabel?.text = strDate
        cell.alomofireDegreeLabel?.text = "\(Int(weatherInformation?.temp?.day ?? 000))℃"
        let currentDateTime = Date()
        print(currentDateTime)
        return cell
    }
}
