//
//  LoginViewController.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let loginViewModel = LoginViewModel()
    let alertControllerManager = AlertControllerManger.shared
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loginBtn.layer.cornerRadius = 20
        signUpBtn.designButton(title: "Don’t have an account? Sign Up", changeColorText: "Sign Up")
        username.designTextField()
        password.designTextField()
        password.isSecureTextEntry = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    @IBAction func loginBtnHandler(_ sender: Any) {
        guard let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
        activityIndicator.startAnimating()
        loginBtn.isEnabled = false
        if loginViewModel.loginValidation(emailId: username.text ?? "", password: password.text ?? "") {
            loginViewModel.loginAPIRequest(email: username.text ?? "", password: password.text ?? "") { success in
                self.activityIndicator.stopAnimating()
                if success {
                    let navcontroller = UINavigationController(rootViewController: vc)
                    self.view.window?.rootViewController = navcontroller
                    self.view.window?.makeKeyAndVisible()
                } else {
                    self.activityIndicator.stopAnimating()
                    self.loginBtn.isEnabled = true
                    self.alertControllerManager.showAlert(on: self, title: "Information", message: self.loginViewModel.message)
                }
            }
        } else {
            loginBtn.isEnabled = true
            self.activityIndicator.stopAnimating()
            self.alertControllerManager.showAlert(on: self, title: "Information", message: loginViewModel.message)
        }
    }
    
    @IBAction func signUpBtnHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
}
