//
//  ToDoModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation

struct ToDoModel: Codable{
    var emailId: String
    var password: String
    var taskAssigned = [Task]()
    var taskCompleted = [Task]()
}
