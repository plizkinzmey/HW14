import UIKit

class ViewController2a: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.text = Persistance.shared.userFirstName
        lastNameField.text = Persistance.shared.userLastName
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        Persistance.shared.userFirstName = firstNameField.text
        Persistance.shared.userLastName = lastNameField.text
    }
    
}

