//
//  Validation.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation
class Validation {
    static func validation(_ title: String) -> Bool {
        if title.count > 0 {
            return true
        }
        return false
    }
}

class PasswordValidation{
    static func isValidPassword(_ password: String) -> Bool {
         let minLength = 8

         let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
         let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
         let hasDigit = password.rangeOfCharacter(from: .decimalDigits) != nil
         let hasSpecialCharacter = password.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%^&+=")) != nil

         return password.count >= minLength && hasUppercase && hasLowercase && hasDigit && hasSpecialCharacter
     }
}

class EmailValidation{
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}", options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        return emailRegex.firstMatch(in: email, options: [], range: range) != nil
    }
}

class FullNameValidation{
    static func isValidFullName(_ fullName: String) -> Bool {
        let fullNameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]+$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: fullName.utf16.count)
        return fullNameRegex.firstMatch(in: fullName, options: [], range: range) != nil
    }
}
