//
//  NewTaskViewController.swift
//  HW14
//
//  Created by Александр Бабкин on 23.10.2021.
//

import UIKit

class NewTaskViewController: UIViewController, UITextFieldDelegate


{
    
    @IBOutlet weak var newTaskField: UITextField!
    @IBOutlet weak var closeFormNewTaskButton: UIButton!
    
    weak var newTaskDelegate: NewTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTaskField.becomeFirstResponder()
        newTaskField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func buttonActions() {
        if newTaskField.text?.isEmpty ?? true {
            newTaskDelegate?.updateConstraintTaskTableTop()
            self.dismiss(animated: false, completion: nil)
            
        } else {
            newTaskDelegate?.addTask(taskText: newTaskField.text!)
            newTaskField.text = ""
        }
    }
    
    
    @IBAction func newTaskButtonAction(_ sender: Any) {
        buttonActions()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonActions()
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
