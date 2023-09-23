//
//  SignUpViewController.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var summit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullName.designTextField()
        email.designTextField()
        password.designTextField()
        summit.designButton()
        self.title="SignUp"
    }
    
    @IBAction func submit(_ sender: Any) {
        let userDetail = UserDetailStruct(fullName: fullName.text!, email: email.text!, password: password.text!)
        if SignUpViewModel.signUpValidation(userDetail){
//            print("ok")
            userData.append(userDetail)
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
