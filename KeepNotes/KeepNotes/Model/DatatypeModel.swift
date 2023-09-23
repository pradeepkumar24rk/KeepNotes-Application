//
//  DatatypeModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation

struct Task {
    var Title = String()
    var Desc = String()
}

struct UserDetailStruct{
    var fullName: String
    var email: String
    var password: String
    var taskAssigned = [Task]()
    var taskCompleted = [Task]()
}
