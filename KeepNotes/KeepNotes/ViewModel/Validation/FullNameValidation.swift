//
//  FullNameValidation.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import Foundation

class FullNameValidation{
    static func isValidFullName(_ fullName: String) -> Bool {
        let fullNameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]+$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: fullName.utf16.count)
        return fullNameRegex.firstMatch(in: fullName, options: [], range: range) != nil
    }
}
