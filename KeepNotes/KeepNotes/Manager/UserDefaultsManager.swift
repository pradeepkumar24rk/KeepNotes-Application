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
    
    func setUserDict(_ newValue: [String: [ToDoModel]]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: userDataKey)
    }
    
    func getUserDict() -> [String: [ToDoModel]] {
        if let data = UserDefaults.standard.value(forKey: userDataKey) as? Data,
           let decodedValue = try? PropertyListDecoder().decode([String: [ToDoModel]].self, from: data) {
            return decodedValue
        }
        return ["": [ToDoModel]()]
    }
    
    var users: [ToDoModel] {
        get {
            if let users = getUserDict()["users"] {
                return users
            }
            return []
        }
        set {
            setUserDict(["users":newValue])
        }
    }
}
