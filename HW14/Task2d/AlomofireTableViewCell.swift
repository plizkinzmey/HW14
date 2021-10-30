//
//  AlomofireTableViewCell.swift
//  HW12
//
//  Created by Aleksandr Babkin on 26.03.2021.
//

import UIKit

class AlomofireTableViewCell: UITableViewCell {
    @IBOutlet weak var alomofireDateLabel: UILabel!
    @IBOutlet weak var alomofireDegreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
