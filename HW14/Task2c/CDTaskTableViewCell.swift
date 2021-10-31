//
//  CDTaskTableViewCell.swift
//  HW14
//
//  Created by Александр Бабкин on 12.09.2021.
//

import UIKit
import BEMCheckBox

class CDTaskTableViewCell: UITableViewCell {
    
    var checkBoxAction: ((UITableViewCell) -> Void)?

    @IBOutlet weak var checkBoxCD: BEMCheckBox!
    @IBOutlet weak var CDTaskCellLAbel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkBoxAction(_ sender: Any) {
        checkBoxAction?(self)
    }
}
