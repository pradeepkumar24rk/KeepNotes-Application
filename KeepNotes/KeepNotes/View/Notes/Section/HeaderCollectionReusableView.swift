//
//  SectionTableViewHeader.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var header: UILabel!
    
    static let identifier = "HeaderCollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     
    static func nib() -> UINib {
        return UINib(nibName: "HeaderCollectionReusableView", bundle: nil) //nib file name is xib file name
    }
    
    public func configure(with heading: String) {
        header.text = heading
    }
}
