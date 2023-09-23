//
//  LoginViewController.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    var info:UserDetailStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login.isEnabled = false
        email.layer.cornerRadius = 20
        email.layer.masksToBounds = true
        password.layer.cornerRadius = 20
        password.layer.masksToBounds = true
        login.layer.cornerRadius = 20
        login.layer.masksToBounds = true
        signUp.layer.cornerRadius = 20
        signUp.layer.masksToBounds = true
        password.isSecureTextEntry = true
    }
    
    @IBAction func login(_ sender: Any) {
        if LoginViewModel.check(info!, email.text!, password.text!){
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            
            if let data = info?.fullName{
                vc.FullName = data
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let alert:UIAlertController=UIAlertController(
                title: "Warning",
                message: LoginViewModel.message,
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
    
    @IBAction func signUp(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: PassData{
    func passData(_ Into: UserDetailStruct) {
        info = Into
        login.isEnabled = true
    }
}
