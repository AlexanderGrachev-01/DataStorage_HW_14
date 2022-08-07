import UIKit

class UserDefaultsVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Persistance.shared.userName != "" {
            nameTextField.text = Persistance.shared.userName
        }
        if Persistance.shared.userSurname != "" {
            surnameTextField.text = Persistance.shared.userSurname
        }
    }
    
    @IBAction func changeName(_ sender: Any) {
        if let name = nameTextField.text {
            Persistance.shared.userName = name
        }
        if let surname = surnameTextField.text {
            Persistance.shared.userSurname = surname
        }
    }
}
