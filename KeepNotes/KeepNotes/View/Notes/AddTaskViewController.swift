//
//  AddTaskViewController.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

protocol PassListDataDelegate{
    func passData(taskTitle: String,taskDesc: String )
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDesc: UITextView!
    
    var delegate: PassListDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        taskDesc.layer.cornerRadius = 4
    }

    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if AddTaskViewModel.tileValidation(taskTitle.text ?? "") {
            delegate?.passData(taskTitle: taskTitle.text ?? "" , taskDesc: taskTitle.text ?? "")
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert:UIAlertController=UIAlertController(
                title: "Task Name Error",
                message: "Your task Name should be filled",
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: UIAlertAction.Style.default,
                    handler: nil
                )
            )
            present(alert,animated: true,completion: nil)
        }
    }
}
