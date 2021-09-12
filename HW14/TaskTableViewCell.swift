//
//  TaskTableViewCell.swift
//  HW14
//
//  Created by Александр Бабкин on 08.09.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func doneBUttonAction(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
