//
//  AlertManager.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 13/10/23.
//

import Foundation
import UIKit

class AlertControllerManger {
    static let shared = AlertControllerManger()
    
    func showAlert(on viewController: UIViewController, title: String, message: String, disableCancel: Bool = false, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style: .default, handler: { _ in
            completion?()
        }))
        if !disableCancel {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        viewController.present(alert, animated: true)
    }
}
