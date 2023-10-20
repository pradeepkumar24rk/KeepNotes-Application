//
//  SignUpViewModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation

class SignUpViewModel {
    var message = String()
    var data: ToDoMapperModel?
    var networkManager =  NetworkManager.shared
    
    func userDetailMapperModel(emailId: String, password: String) {
        data = ToDoMapperModel(JSON:["email": emailId, "password": password])
    }
    
    func signUpValidation() -> Bool {
        if !isRequiredFieldFilled() {
            message = "Please fill the Required field"
            return false
        } else if !TDHelper.shared.isValidEmail(check: data?.email ?? "") {
            message = "Please Enter the valid Email"
            return false
        } else if !TDHelper.shared.isValidPassword(check: data?.password ?? "") {
            message = "Please Enter the valid Password.\nPassword should have 6 character length, 1 special character, 1 number and 1 capital letter"
            return false
        }
        message = "User is created successfully"
        return true
    }
    
    func isRequiredFieldFilled() -> Bool {
        if ( (data?.email == "") || (data?.password == "") ){
            return false
        }
        return true
    }
    
    func signUpAPIRequest(completionHandler: @escaping (Bool) -> Void) {
        networkManager.signUpAPI(parameters: data!) { result, statusBool in
            do {
                switch result {
                    case .success(let data):
                        if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String: Any] {
                            print(json)
                            if !statusBool {
                                if let errors = json["message"] as? [String] {
                                        let errorMessage = "\(errors.joined(separator: ",\n "))"
                                        self.message = errorMessage
                                }
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

