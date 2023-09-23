//
//  PasswordValidation.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import Foundation

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
