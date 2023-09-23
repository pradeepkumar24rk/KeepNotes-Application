//
//  SectionTableViewCell.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

class SectionTableView {
    static func sectionHeader(_ info:String) -> UIView{
        let header = UIView()
        let label = UILabel()
        header.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Lato-Bold", size: 19)
//        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.text = info
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: header.topAnchor, constant: 0.0),
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 12.0)
        ])
        return header
    }
}
