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
    @IBOutlet weak var checkBoxDone: BEMCheckBox!
    @IBOutlet weak var editTaskButton: UIButton!
    @IBOutlet weak var editTaskField: UITextField!
    @IBOutlet weak var exitWithoutSaveButton: UIButton!
    @IBOutlet weak var acceptEditTaskButton: UIButton!
    
    weak var taskUpdateDelegate: TaskUpdateDelegate?
    var taskId: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func editTaskAction(_ sender: Any) {
        nameTask.isHidden = true
        checkBoxDone.isHidden = true
        editTaskButton.isHidden = true
        editTaskField.isHidden = false
        acceptEditTaskButton.isHidden = false
        exitWithoutSaveButton.isHidden = false
        editTaskField.text = nameTask.text
        editTaskField.becomeFirstResponder()
    }
    
    @IBAction func exitWithoutSaveAction(_ sender: Any) {
        nameTask.isHidden = false
        checkBoxDone.isHidden = false
        editTaskButton.isHidden = false
        editTaskField.isHidden = true
        acceptEditTaskButton.isHidden = true
        exitWithoutSaveButton.isHidden = true
    }
    
    @IBAction func acceptEditButtonAction(_ sender: Any) {
        taskUpdateDelegate?.updateTask(taskText: editTaskField.text!, taskId: taskId!)
        nameTask.isHidden = false
        checkBoxDone.isHidden = false
        editTaskButton.isHidden = false
        editTaskField.isHidden = true
        acceptEditTaskButton.isHidden = true
        exitWithoutSaveButton.isHidden = true
    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        checkBoxAction?(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
