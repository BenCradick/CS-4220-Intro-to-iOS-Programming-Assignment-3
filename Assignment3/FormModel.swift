/*
 Ben Cradick
 07-18-18
 Assignment 3
 Hold onto your pants because this code belongs served with red sauce and meat balls
 */

import Foundation

class FormModel {
    
    init() {
        validName = false
        validEmail = false
        validPassword = false
        validPhoneNumber = false
        
    }
    private var validName: Bool
    private var validEmail: Bool
    private var validPassword: Bool
    private var validPhoneNumber: Bool
    
    private func checkEmail(emailAddress: String?)->Bool{
        print(#function)
        let email = emailAddress ?? ""
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    //checks for password with
    //1 capital letter (?=.*[[:upper:]])
    //1 lower case(?=.*[[:lower:]]) POSIX classes
    //1 special character (?=.*[!@#$&*]) plus
    //1 number (?=.*[0-9])
    //and minumum length of 8 .{8,0}
    private func checkPassword(password: String?)->Bool{
        print(#function)
        let pass = password ?? ""
        let passRegEx = "^(?=.*?[0-9])(?=.*?[[:lower:]])(?=.*?[[:upper:]])(?=.*?[#?!@$%^&*]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: pass)
    }
    private func checkPhoneNumber(number: String?)-> Bool{
        print(#function)
        let num = number ?? ""
        let phoneRegEx = "^\\d{10,}$"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneNumberTest.evaluate(with: num)
    }
    private func checkName(name: String?)->Bool{
        print(#function)
        let name = name ?? ""
        let nameRegEx = "^.{3,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
    //perhaps should have been done with an enumeration
    public func getValidName()->Bool{
        print(#function)
        return validName
    }
    public func getValidEmail()->Bool{
        print(#function)
        return validEmail
    }
    public func getValidPassword()->Bool{
        print(#function)
        return validPassword
    }
    public func getValidPhoneNumber()->Bool{
        print(#function)
        return validPhoneNumber
    }
    public func readyForSubmit()->Bool{
        print(#function)
        guard validName else{
            return false
        }
        guard validEmail else{
            return false
        }
        guard validPassword else{
            return false
        }
        guard validPhoneNumber else{
            return false
        }
        return true
    }
    public func setValidName(name: String?){
        print(#function)
       validName = checkName(name: name)
    }
    public func setValidEmail(email: String?){
        print(#function)
        validEmail = checkEmail(emailAddress: email)
    }
    public func setValidPassword(pass: String?){
        print(#function)
        validPassword = checkPassword(password: pass)
    }
    public func setValidPhoneNumber(number: String?){
        print(#function)
        print(#function)
        validPhoneNumber = checkPhoneNumber(number: number)
    }
    public func reset(){
        validName = false
        validEmail = false
        validPassword = false
        validPhoneNumber = false
    }
    
    
}

