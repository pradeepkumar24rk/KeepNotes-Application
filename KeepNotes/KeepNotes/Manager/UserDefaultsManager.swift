//
//  UserDefaults.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let userDataKey = "UserData"
    
    private init() {}
    
    func getValue(key: String) -> String {
        if let val =  UserDefaults.standard.value(forKey: key) as? String {
            return val
        }
        return ""
    }
    
    func setValue(key: String, val: String) {
        UserDefaults.standard.set(val, forKey: key)
    }
    
    var username: String {
        get {
            getValue(key: "username")
        }
        set {
            setValue(key: "username", val: newValue)
        }
    }
    
    var password: String {
        get {
            getValue(key: "password")
        }
        set {
            setValue(key: "password", val: newValue)
        }
    }
}
