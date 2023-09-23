//
//  EmailValidation.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import Foundation

class EmailValidation{
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}", options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        return emailRegex.firstMatch(in: email, options: [], range: range) != nil
    }
}
