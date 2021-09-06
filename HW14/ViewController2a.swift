import UIKit

class ViewController2a: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
   
    var previousfirstNameValue: String?
    var previouslastNameValue: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.text = Persistance.shared.userFirstName
        lastNameField.text = Persistance.shared.userLastName
        previousfirstNameValue = Persistance.shared.userFirstName
        previouslastNameValue = Persistance.shared.userLastName
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        if firstNameField.text != previousfirstNameValue || lastNameField.text != previouslastNameValue {
            Persistance.shared.userFirstName = firstNameField.text
            Persistance.shared.userLastName = lastNameField.text
        }
    }
    
}

