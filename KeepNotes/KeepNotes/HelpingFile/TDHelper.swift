//
//  TDHelper.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation
// this file for validation and helpfile for todolist
class TDHelper {
    static let shared = TDHelper()
    
    func isValidEmail(check email: String) -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}", options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        return emailRegex.firstMatch(in: email, options: [], range: range) != nil
        
    }
    
    func isValidPassword(check password: String) -> Bool {
        let mininumCharater = 6
        let hasUpperCase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowerCase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasSpecialCharacter = password.rangeOfCharacter(from: CharacterSet(charactersIn: "$!#%^&*?><+-_@")) != nil
        return password.count >= mininumCharater && hasUpperCase && hasLowerCase && hasSpecialCharacter
    }
    
    func isValidName(check name: String) -> Bool {
        let nameRegex = try! NSRegularExpression(pattern: "[a-zA-z]+")
        let range = NSRange(location: 0, length: name.utf16.count)
        return nameRegex.firstMatch(in: name, options: [], range: range) != nil
    }
    
    func isValidPhoneNumber(check phoneNumber: String) -> Bool {
        let Number = String(phoneNumber[phoneNumber.index(phoneNumber.startIndex, offsetBy: 1)...])
        if Int(Number) != nil {
                return true
        }
        return false
    }
    
    func isValidPinCode(check pinCode: String) -> Bool {
        if Int(pinCode) != nil {
            if pinCode.count == 6 {
                return true
            }
        }
        return false
    }
}
