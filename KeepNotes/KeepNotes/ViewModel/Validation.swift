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
