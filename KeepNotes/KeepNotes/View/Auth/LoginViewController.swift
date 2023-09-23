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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        email.designTextField()
        password.designTextField()
        login.designButton()
        signUp.designButton()
    }
    
    @IBAction func login(_ sender: Any) {
        if LoginViewModel.check(email.text!, password.text!){
            let vc = UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
