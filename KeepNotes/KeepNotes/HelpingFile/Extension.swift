//
//  Extension.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import Foundation
import UIKit

extension UIView {
    func designView() {
            self.layer.cornerRadius = 15
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.layer.shadowRadius = 12
        self.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16).cgColor
    }
}

extension UIButton {
    func designButton() {
        self.layer.cornerRadius = 10
    }
}

extension UITextField {
    func designTextField() {
        self.layer.cornerRadius = 10
    }
}
