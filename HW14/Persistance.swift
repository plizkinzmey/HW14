import Foundation

class Persistance {
    static let shared = Persistance()
    
    private let kUserFirstName = "Persistance.kUserFirstName"
    private let kUserLastName = "Persistance.kUserLastName"
    
    var userFirstName: String? {
        set { UserDefaults.standard.setValue(newValue, forKey: kUserFirstName) }
        get { return UserDefaults.standard.string(forKey: kUserFirstName) }
    }
    
    var userLastName: String? {
        set { UserDefaults.standard.setValue(newValue, forKey: kUserLastName) }
        get { return UserDefaults.standard.string(forKey: kUserLastName) }
    }
}
