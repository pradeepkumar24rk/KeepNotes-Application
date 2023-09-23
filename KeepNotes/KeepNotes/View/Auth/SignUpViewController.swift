//
//  SignUpViewController.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import UIKit

struct UserDetailStruct{
    var fullName: String
    var email: String
    var password: String
}

protocol PassData{
    func passData(_ Into:UserDetailStruct)
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var summit: UIButton!
    
    var delegate:PassData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullName.layer.cornerRadius = 20
        fullName.layer.masksToBounds = true
        email.layer.cornerRadius = 20
        email.layer.masksToBounds = true
        password.layer.cornerRadius = 20
        password.layer.masksToBounds = true
        summit.layer.cornerRadius = 20
        summit.layer.masksToBounds = true

        self.title="SignUp"
    }
    
    @IBAction func submit(_ sender: Any) {
        let userDetailStruct = UserDetailStruct(fullName: fullName.text!, email: email.text!, password: password.text!)
        if SignUpViewModel.signUpValidation(userDetailStruct){
//            print("ok")
            delegate?.passData(userDetailStruct)
        }
        else{
            let alert:UIAlertController=UIAlertController(
                title: "Warning",
                message: SignUpViewModel.message,
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
        self.navigationController?.popViewController(animated: true)
    }
}
