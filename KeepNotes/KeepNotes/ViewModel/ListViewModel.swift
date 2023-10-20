//
//  DataViewModel.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation
import UIKit

class ListViewModel {
    let networkManager = NetworkManager.shared

    var message =  String()
    var taskAssigned = [Task]()
    var taskCompleted = [Task]()
    let sectionNameArray = ["To Do", "Completed"]
    
    func totalTaskCount() -> Int {
        return taskAssigned.count + taskCompleted.count
    }
    
//    func didUpdateTask(_ row: Int) {
//        taskCompleted.insert(taskAssigned[row], at: 0)
//        taskAssigned.remove(at: row)
//    }
//
//    func didAddTask(_ data: Task) {
//        taskAssigned.append(data)
//    }
    
    func listAPIRequest(completionHandler: @escaping (Bool) -> Void) {
        networkManager.listAPI() { result, statusBool in
            do {
                switch result {
                    case .success(let data):
                        if statusBool{
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                                print(json)
                                for val in json {
                                    guard let task = Task(JSON: val) else { return }
                                    if let status = val["completed"] as? Bool {
                                        if status == true {
                                            self.taskCompleted.append(task)
                                        } else {
                                            self.taskAssigned.append(task)
                                        }
                                    }
                                }
                            }
                        } else {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print(json)
                                guard let jsonValue = json["error"] as? String else { return }
                                self.message = jsonValue
                            }
                        }
                        completionHandler(statusBool)
                        
                    case .failure(let error):
                        print(error)
                        self.message = "Server Down Or something went wrong\n Please try later"
                        completionHandler(statusBool)
                }
            } catch {
                print(error)
                self.message = "Server Down Or something went wrong\n Please try later"
                completionHandler(statusBool)
            }
        }
    }
    
    func addListAPIRequest(parameters: [String: String],completionHandler: @escaping (Bool) -> Void) {
        networkManager.addListAPI(parameters: parameters) { result, statusBool in
            do {
                switch result {
                    case .success(let data):
                        if statusBool{
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print(json)
                                guard let task = Task(JSON: json) else { return }
                                self.taskAssigned.append(task)
                            }
                        } else {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print(json)
                                guard let jsonValue = json["error"] as? String else { return }
                                self.message = jsonValue
                            }
                        }
                        completionHandler(statusBool)
                        
                    case .failure(let error):
                        print(error)
                        self.message = "Server Down Or something went wrong\n Please try later"
                        completionHandler(statusBool)
                }
            } catch {
                print(error)
                self.message = "Server Down Or something went wrong\n Please try later"
                completionHandler(statusBool)
            }
        }
    }
    
    func completedListAPIRequest(id: Int,completionHandler: @escaping (Bool) -> Void) {
        networkManager.completionListAPI(id: id) { result, statusBool in
            do {
                switch result {
                    case .success(let data):
                        if statusBool{
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print(json)
                                guard let task = Task(JSON: json) else { return }
                                self.taskCompleted.append(task)
                            }
                        } else {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print(json)
                                guard let jsonValue = json["error"] as? String else { return }
                                self.message = jsonValue
                            }
                        }
                        completionHandler(statusBool)
                        
                    case .failure(let error):
                        print(error)
                        self.message = "Server Down Or something went wrong\n Please try later"
                        completionHandler(statusBool)
                }
            } catch {
                print(error)
                self.message = "Server Down Or something went wrong\n Please try later"
                completionHandler(statusBool)
            }
        }
    }
}

