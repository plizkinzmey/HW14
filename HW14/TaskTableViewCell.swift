//
//  TaskTableViewCell.swift
//  HW14
//
//  Created by Александр Бабкин on 08.09.2021.
//

import UIKit
import BEMCheckBox

class TaskTableViewCell: UITableViewCell {
    var checkBoxAction: ((UITableViewCell) -> Void)?
    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var checkBoxDone: BEMCheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    @IBAction func doneBUttonAction(_ sender: Any) {
//
//    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        checkBoxAction?(self)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
