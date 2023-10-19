//
//  SignUpViewModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

class SignUpViewModel {
    
    let userDefaults = UserDefaultsManager.shared
    let lastUser = UserDefaultsManager.shared.users.count - 1
    var message = String()
    
    func signUpValidation(check data: ToDoModel) -> Bool {
        if !isRequiredFieldFilled(check: data) {
            message = "Please fill the Required field"
            return false
        } else if !TDHelper.shared.isValidEmail(check: data.emailId) {
            message = "Please Enter the valid Email"
            return false
        } else if !TDHelper.shared.isValidPassword(check: data.password) {
            message = "Please Enter the valid Password.\nPassword should have 6 character length, 1 special character, 1 number and 1 capital letter"
            return false
        } else if isAlreadyUserAvailable(check: data) {
            message = "Email id is already exist"
            return false
        }
        message = "User is created successfully"
        return true
    }
    
    func isRequiredFieldFilled(check data: ToDoModel) -> Bool {
        if ( (data.emailId == "") || (data.password == "") ){
            return false
        }
        return true
    }
    
    func isAlreadyUserAvailable(check data: ToDoModel) -> Bool {
        if let _ = userDefaults.users.firstIndex(where: { defaultsValue in
            data.emailId == defaultsValue.emailId
        }) {
            return true
        }
        return false
    }
    
    func addNewUser(newUser: ToDoModel) {
       userDefaults.users.append(newUser)
    }
}

