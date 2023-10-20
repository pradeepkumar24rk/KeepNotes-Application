//
//  SignUpViewController.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    let alertControllerManager = AlertControllerManger.shared
    let signUpViewModel = SignUpViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        signUpBtn.layer.cornerRadius = 20
        loginBtn.designButton(title: "Already have an account? Login", changeColorText: "Login")
        username.designTextField()
        password.designTextField()
        password.isSecureTextEntry = true
    }
    @IBAction func signUpBtnHandler(_ sender: Any) {
        signUpViewModel.userDetailMapperModel(emailId: username.text ?? "", password: password.text ?? "")
        signUpBtn.isEnabled = false
        if signUpViewModel.signUpValidation() {
            activityIndicator.startAnimating()
//signupRequest
            signUpViewModel.signUpAPIRequest() { isSuccess in
                self.activityIndicator.stopAnimating()
                if isSuccess {
                    self.alertControllerManager.showAlert(on: self, title: "Congratulations", message: self.signUpViewModel.message, disableCancel: true) {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController")
                        let navcontroller = UINavigationController(rootViewController: vc)
                        self.view.window?.rootViewController = navcontroller
                        self.view.window?.makeKeyAndVisible()
                    }
                } else {
                    self.signUpBtn.isEnabled = true
                    self.alertControllerManager.showAlert(on: self, title: "Invalid", message: self.signUpViewModel.message,disableCancel: true)
                }
            }
        } else {
            signUpBtn.isEnabled = true
            alertControllerManager.showAlert(on: self, title: "Invalid", message: signUpViewModel.message)
        }
    }
    
    @IBAction func loginBtnHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
}
