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
    
    
    
    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var checkBoxDone: BEMCheckBox!
    @IBOutlet weak var editTaskButton: UIButton!
    @IBOutlet weak var editTaskField: UITextField!
    @IBOutlet weak var exitWithoutSaveButton: UIButton!
    @IBOutlet weak var acceptEditTaskButton: UIButton!
    
    weak var taskUpdateCDDelegate: TaskUpdateCDDelegate?
    var model: Tasks?
    var isDone: Bool?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        taskUpdateCDDelegate?.updateTask(model: model!, newTaskName: nil, isDone: isDone)
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
        taskUpdateCDDelegate?.updateTask(model: model!, newTaskName: editTaskField.text!, isDone: nil)
        //        taskUpdateCDDelegate?.updateTask(taskText: editTaskField.text!, taskId: taskId!)
        nameTask.isHidden = false
        checkBoxDone.isHidden = false
        editTaskButton.isHidden = false
        editTaskField.isHidden = true
        acceptEditTaskButton.isHidden = true
        exitWithoutSaveButton.isHidden = true
    }
}
