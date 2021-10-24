//
//  WeatherTableViewCell.swift
//  HW12
//
//  Created by Aleksandr Babkin on 25.03.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {


    @IBOutlet weak var degreeWeatherLabel: UILabel!
    @IBOutlet weak var dateWeatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
