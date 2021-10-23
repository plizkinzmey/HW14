//
//  NewTaskViewController.swift
//  HW14
//
//  Created by Александр Бабкин on 23.10.2021.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var newTaskField: UITextField!
    @IBOutlet weak var closeFormNewTaskButton: UIButton!
    
    weak var newTaskDelegate: NewTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTaskField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func newTaskButtonAction(_ sender: Any) {
        if newTaskField.text?.isEmpty ?? true {
            newTaskDelegate?.updateConstraintTaskTableTop()
            self.dismiss(animated: false, completion: nil)
         
        } else {
            newTaskDelegate?.update(taskText: newTaskField.text!)
            newTaskDelegate?.updateConstraintTaskTableTop()
            self.dismiss(animated: false, completion: nil)
        }
       
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
