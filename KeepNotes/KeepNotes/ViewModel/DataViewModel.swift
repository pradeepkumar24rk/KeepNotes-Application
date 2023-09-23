//
//  DataViewModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation

var taskAssigned = [Task]()

var taskCompleted = [Task]()

let sectionNameArray = ["ToDo", "Completed"]

//var userData = [UserDetailStruct]()
var userData: [UserDetailStruct] = [
    UserDetailStruct(fullName: "hell", email: "hello@gmail.com", password: "Hello@123",
        taskAssigned: [
        Task(Title: "hello",Desc: "good"),
        Task(Title: "hello",Desc: "good"),
        Task(Title: "hello",Desc: "good")
        ]),

]
