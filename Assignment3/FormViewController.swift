import UIKit

class FormViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var nameConfirmation: UIImageView!
    @IBOutlet weak var emailConfirmation: UIImageView!
    @IBOutlet weak var passwordConfirmation: UIImageView!
    @IBOutlet weak var phoneNumberConfirmation: UIImageView!
}



