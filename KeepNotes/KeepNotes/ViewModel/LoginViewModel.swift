//
//  LoginViewModel.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import Foundation

class LoginViewModel{
    static var message = ""
    
    static func check(_ signUpData: UserDetailStruct,
               _ email: String,
               _ password: String
    ) -> Bool{
        if signUpData.email != email{
            message = "Email is Wrong"
            return false
        }
        else if signUpData.password != password{
            message = "Password is wrong"
            return false
        }
        return true
    }
}
