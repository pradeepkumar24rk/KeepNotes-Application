//
//  DatatypeModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation
import ObjectMapper

struct Task: Mappable {
    var id = Int()
    var Title = String()
    var Desc = String()
    var completed = Bool()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        Title <- map["name"]
        Desc <- map["description"]
        completed <- map["completed"]
    }
}
