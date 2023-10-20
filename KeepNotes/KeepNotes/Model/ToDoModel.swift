//
//  ToDoModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation
import ObjectMapper

struct ToDoMapperModel: Mappable{
    var email = String()
    var password = String()
    var taskAssigned = [Task]()
    var taskCompleted = [Task]()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
    }
    
}
