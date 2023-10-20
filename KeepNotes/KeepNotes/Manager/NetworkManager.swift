//
//  NetworkManager.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkManager {
    var userDefaults = UserDefaultsManager.shared
    static let shared = NetworkManager()
    private var message = String()
    
    func signUpAPI(parameters: ToDoMapperModel, completionHandler: @escaping (Result<Data, Error>, Bool) -> Void) {
        let url = "https://mobile-team-test-api.onrender.com/users/sign_up.json"
        let jsonDictionary = parameters.toJSON()
        print("JSON Dictionary:\n\(jsonDictionary)")
        AF.request(url, method: .post, parameters: ["user": jsonDictionary]).response { res in
            switch res.result {
                case .success(let data):
                    guard let data = data else {return}
                    if let httpResponse = res.response, (200..<300).contains(httpResponse.statusCode) {
                        completionHandler(.success(data), true)
                    } else {
                        completionHandler(.success(data), false)
                    }
                case .failure(let error):
                    completionHandler(.failure(error),false)
            }
        }
    }
    
    func loginAPI(email: String, password: String, completionHandler: @escaping (Result<Data, Error>, Bool) -> Void) {
        let url = "https://mobile-team-test-api.onrender.com/users/log_in.json"
        let parameters = ["user": ["email": email, "password": password]]
        
        AF.request(url, method: .post, parameters: parameters).response { res in
            switch res.result {
                case .success(let data):
                    guard let data = data else {return}
                    if let httpResponse = res.response, (200..<300).contains(httpResponse.statusCode) {
                        completionHandler(.success(data), true)
                    } else {
                        completionHandler(.success(data), false)
                    }
                case .failure(let error):
                    completionHandler(.failure(error),false)
            }
        }
    }
    
    func listAPI(completionHandler: @escaping (Result<Data, Error>, Bool) -> Void) {
        let url = "https://mobile-team-test-api.onrender.com/todos.json"
        
        let headers: HTTPHeaders = [
            .authorization(username: userDefaults.username, password: userDefaults.password)
        ]
        
        AF.request(url, method: .get, headers: headers)
            .response { res in
            switch res.result {
                case .success(let data):
                    guard let data = data else {return}
                    if let httpResponse = res.response, (200..<300).contains(httpResponse.statusCode) {
                        completionHandler(.success(data), true)
                    } else {
                        completionHandler(.success(data), false)
                    }
                case .failure(let error):
                    completionHandler(.failure(error),false)
            }
        }
    }
    
    func addListAPI(parameters: [String: String], completionHandler: @escaping (Result<Data, Error>, Bool) -> Void) {
        let url = "https://mobile-team-test-api.onrender.com/todos.json"
        
        let headers: HTTPHeaders = [
            .authorization(username: userDefaults.username, password: userDefaults.password)
        ]
        
        AF.request(url, method: .post, parameters:["todo": parameters] , headers: headers).response { res in
            switch res.result {
                case .success(let data):
                    guard let data = data else {return}
                    if let httpResponse = res.response, (200..<300).contains(httpResponse.statusCode) {
                        completionHandler(.success(data), true)
                    } else {
                        completionHandler(.success(data), false)
                    }
                case .failure(let error):
                    completionHandler(.failure(error),false)
            }
        }
    }
    
    func completionListAPI(id: Int, completionHandler: @escaping (Result<Data, Error>, Bool) -> Void) {
        let url = "https://mobile-team-test-api.onrender.com/todos/\(id).json"
        
        
        let headers: HTTPHeaders = [
            .authorization(username: userDefaults.username, password: userDefaults.password)
        ]
        
        let parameters = ["todo": ["completed" : true]]
        
        AF.request(url, method: .put, parameters: parameters, headers: headers).response { res in
            switch res.result {
                case .success(let data):
                    guard let data = data else {return}
                    if let httpResponse = res.response, (200..<300).contains(httpResponse.statusCode) {
                        completionHandler(.success(data), true)
                    } else {
                        completionHandler(.success(data), false)
                    }
                case .failure(let error):
                    completionHandler(.failure(error),false)
            }
        }
    }
}
