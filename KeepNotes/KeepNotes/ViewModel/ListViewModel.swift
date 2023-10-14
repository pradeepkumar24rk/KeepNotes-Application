//
//  DataViewModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation
import UIKit

class ListViewModel {
    let userDefaults = UserDefaultsManager.shared
    var userIndex = Int()
    var taskAssigned: [Task] {
        get {
            userDefaults.users[userIndex].taskAssigned
        }
        set {
            userDefaults.users[userIndex].taskAssigned = newValue
        }
    }
    var taskCompleted: [Task] {
        get {
            return userDefaults.users[userIndex].taskCompleted
        }
        set {
            userDefaults.users[userIndex].taskCompleted = newValue
        }
    }
    let sectionNameArray = ["To Do", "Completed"]
    
    func totalTaskCount() -> Int {
        return taskAssigned.count + taskCompleted.count
    }
    
    func didUpdateTask(_ row: Int) {
        taskCompleted.insert(taskAssigned[row], at: 0)
        taskAssigned.remove(at: row)
    }
    
    func didAddTask(_ data: Task) {
        taskAssigned.append(data)
    }
}

