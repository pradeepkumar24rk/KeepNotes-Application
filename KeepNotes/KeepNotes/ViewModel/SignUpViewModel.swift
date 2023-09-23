//
//  SignUpViewModel.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import Foundation

class SignUpViewModel{
    
    static var message = ""
    
    static func signUpValidation(_ userDetail:UserDetailStruct) -> Bool{
        if !EmailValidation.isValidEmail(userDetail.email){
            message = "EmailId is InValid"
            return false
        }
        else if !PasswordValidation.isValidPassword(userDetail.password){
            message = "PassWord is weak"
            return false
        }
        else if !FullNameValidation.isValidFullName(userDetail.fullName){
            message = "FullName is Invalid"
            return false
        }
        return true
    }
}
