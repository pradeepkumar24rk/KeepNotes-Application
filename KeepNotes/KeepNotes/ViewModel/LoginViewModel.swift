//
//  LoginViewModel.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import Foundation

class LoginViewModel{
    static var message = ""
    
    static func check(_ email: String, _ password: String) -> Bool{
        if let index = userData.firstIndex(where: { data in
            data.email == email
        }){
            if !(userData[index].password == password) {
                message = "Password is wrong"
                return false
            }
        } else {
            message = "Email is Wrong"
            return false
        }
        return true
    }
}
