import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var nameConfirmation: UIImageView!
    @IBOutlet weak var emailConfirmation: UIImageView!
    @IBOutlet weak var passwordConfirmation: UIImageView!
    @IBOutlet weak var phoneNumberConfirmation: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var signUpList: UITextView!
    
    
    
    
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        //creates a new gesture that is broadly defined target is self and #selector tells the objective C code what to look for in my swift code
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        nameField.delegate = self
        nameField.tag = 0
        
        emailAddressField.delegate = self
        emailAddressField.keyboardType = UIKeyboardType.emailAddress
        emailAddressField.tag = 1
        
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        passwordField.tag = 2
        
        phoneNumberField.delegate = self
        phoneNumberField.keyboardType = UIKeyboardType.phonePad
        phoneNumberField.tag = 3
        //weird tags abound becasue I thought it might be causeing an issue with the keyboard jumping
        signUpButton.tag = -1
        
        
        signUpButton.isEnabled = false
        signUpList.isScrollEnabled = false
        signUpList.isEditable = true
    }
    
    
    let formModel = FormModel()
    
    @IBAction func onNameButtonPress(){
        print(#function)
        formModel.setValidName(name: nameField.text)
        changeConfirmationImage(image: nameConfirmation, validityFunc: formModel.getValidName(), tag: nameField)
        if(textFieldShouldReturn(nameField)){
            print("valid name:\(formModel.getValidName()) ")
            
        }
    }
    @IBAction func onEmailAddressButtonPress(){
        print(#function)
        print("valid email:\(formModel.getValidEmail()) ")
        formModel.setValidEmail(email: emailAddressField.text)
        changeConfirmationImage(image: emailConfirmation, validityFunc: formModel.getValidEmail(), tag: emailAddressField)
        if(textFieldShouldReturn(emailAddressField)){
            
            
            print("valid email: \(formModel.getValidEmail())")
            //runNextTextField(tag: getNextFieldTag())
        }

        
    }
    @IBAction func onPasswordButtonPress(){
        print(#function)
        formModel.setValidPassword(pass: passwordField.text)
        changeConfirmationImage(image: passwordConfirmation, validityFunc: formModel.getValidPassword(), tag: passwordField)
        if(textFieldShouldReturn(passwordField)){
            
            print("valid password\(formModel.getValidPassword())")
        }
    }

    @IBAction func onPhoneNumberButtonPress(){
        formModel.setValidPhoneNumber(number: phoneNumberField.text)
        changeConfirmationImage(image: phoneNumberConfirmation, validityFunc: formModel.getValidPhoneNumber(), tag: phoneNumberField)
        
        print(#function)
        if(textFieldShouldReturn(phoneNumberField)){
           
            print("valid PhoneNumber: \(formModel.getValidPhoneNumber())")
        }
    }
    @IBAction func clear(){
        print(#function)
        dismissKeyboard()
        wipeTextFields()
        allImageToDefault()
        resetModel()
    }
    @IBAction func onButtonPressSignUp(){
        print(#function)
        submit()
    }
    @IBAction func onRestartButtonPress(){
        print(#function)
        clear()
        signUpList.text = ""
    }

    /*
 
     MARK: - All Functions below this point are helper functions bc07-18-18
 
    */
    
    func submit(){
        print(#function)
        signUpList.insertText("\(nameField.text!)\n")
        clear()
    }
    //Grabbed this from Stack Overflow
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
            return true
        } else if(!formModel.readyForSubmit()){
            // Not found, so remove keyboard.
            //but don't force above return statements to trigger submit function, this is spaghetti code,
            //I should apply at Riot
            textField.resignFirstResponder()
            return true
        }
        else{
            return false
        }
        // Do not add a line break
       
    }
    
    
    
    func changeConfirmationImage(image: UIImageView, validityFunc: Bool, tag: UITextField){
        print(#function)
        print(validityFunc)
        print(formModel.readyForSubmit())
        if(validityFunc){
            image.image = #imageLiteral(resourceName: "green-check")
            signUpButton.isEnabled = formModel.readyForSubmit()
        }
        else{
            image.image = #imageLiteral(resourceName: "x-mark-3-64")
            signUpButton.isEnabled = formModel.readyForSubmit()
            
        }
        
    }
    
    func allImageToDefault(){
        print(#function)
        nameConfirmation.image = #imageLiteral(resourceName: "check")//there's a check here if you can't see it because of black background
        passwordConfirmation.image = #imageLiteral(resourceName: "check")//ditto
        emailConfirmation.image = #imageLiteral(resourceName: "check")// take a guess
        phoneNumberConfirmation.image = #imageLiteral(resourceName: "check")//same
        
    }
    func getNextFieldTag()->UITextField?{
        print(#function)
        if(formModel.getValidName() == false){
            return nameField
        }
        if(formModel.getValidEmail() == false){
            print(#function)
            print("Returning \(emailAddressField.tag)")
            return emailAddressField
        }
        guard formModel.getValidPassword() else {
            return passwordField
        }
        guard formModel.getValidPhoneNumber() else {
            return phoneNumberField
        }
        return nil
    }
    func wipeTextFields(){
        nameField.text = ""
        emailAddressField.text = ""
        passwordField.text = ""
        phoneNumberField.text = ""
    }
    func resetModel(){
        formModel.reset()
        
    }
    //@objc exposes the function to the underlying objective C APIs
   @objc func dismissKeyboard(){
    // less brute force way of doing this was
    //just n tab tab tab enter e tab tab tab enter.. etc
    nameField.resignFirstResponder()
    emailAddressField.resignFirstResponder()
    passwordField.resignFirstResponder()
    phoneNumberField.resignFirstResponder()
    }
    
}



