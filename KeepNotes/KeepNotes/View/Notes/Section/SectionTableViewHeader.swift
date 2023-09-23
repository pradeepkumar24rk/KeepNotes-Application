//
//  SectionTableViewHeader.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

class SectionTableViewHeader: UITableViewCell {
    @IBOutlet weak var sectionHeader: UILabel!
    
    func update(_ data: String) {
        sectionHeader.text = data
    }
}
