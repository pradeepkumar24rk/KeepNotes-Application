//
//  LoginViewModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation

class LoginViewModel {
    var networkManager = NetworkManager.shared
    var userDefaults = UserDefaultsManager.shared
    
    var message = String()
    var userIndex = Int()
    
    func loginValidation(emailId: String, password: String) -> Bool {
        if !isRequiredFieldFilled(emailId: emailId, password: password) {
            return false
        } else if !TDHelper.shared.isValidEmail(check: emailId) {
            message = "Please Enter the valid EmailId"
            return false
        } else if !TDHelper.shared.isValidPassword(check: password) {
            message = "Please Enter the valid Password.\nPassword should have 6 character length, 1 special character, 1 number and 1 capital letter"
            return false
        }
        return true
    }
    
    func isRequiredFieldFilled(emailId: String, password: String) -> Bool {
        if (emailId == "") && (password == "") {
            message = "Please Enter the emailId and password."
            return false
        } else if (emailId == "") {
            message = "Please Enter the email."
            return false
        } else if (password == "") {
            message = "Please Enter the password."
            return false
        }
        return true
    }
    
    func loginAPIRequest(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        networkManager.loginAPI(email: email, password: password) { result, statusBool  in
            do {
                switch result {
                    case .success(let data):
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print(json)
                            if statusBool {
                                self.userDefaults.username = email
                                self.userDefaults.password = password
                            } else {
                                guard let jsonValue = json["error"] as? String else { return }
                                self.message = jsonValue
                            }
                        }
                        completionHandler(statusBool)
                    case .failure(let error):
                        print(error)
                        self.message = "Server Down Or something went wrong\n Please try later"
                        completionHandler(statusBool)
                }
            } catch {
                print("Error in json: \(error)")
                self.message = "Server Down Or something went wrong\n Please try later"
                completionHandler(false)
            }
        }
    }
}

