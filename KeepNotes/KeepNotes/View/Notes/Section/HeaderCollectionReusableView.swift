//
//  HeaderCollectionReusableView.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 27/09/23.
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
        return UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
    }
    
    public func configure(with heading: String) {
        header.text = heading
    }
}
