//
//  WelcomeViewController.swift
//  weeklyassessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/09/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcome: UILabel!
    
    var FullName: String? = "Name"
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = FullName{
            welcome.text = "Welcome \(name)"
        }
        self.title = "Welcome Page"
    }
    
}
