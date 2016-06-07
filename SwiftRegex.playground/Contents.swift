//: Playground - noun: a place where people can play

import UIKit
extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
}

var str = "Hello, playground"
var isValid = str.isValidEmail()

str = "Hello@"
isValid = str.isValidEmail()

str = "Hello@a"
isValid = str.isValidEmail()

str = "Hello@a."
isValid = str.isValidEmail()

str = "Hello@a.c"
isValid = str.isValidEmail()

str = "Hel%lo@aaa.me"
isValid = str.isValidEmail()


