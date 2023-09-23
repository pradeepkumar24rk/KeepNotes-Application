//
//  Cell1TableViewCell.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

protocol UpdatedDataDelegate{
    func updated(_ info: UITableViewCell)
}

class Cell1TableViewCell: UITableViewCell {
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDesc: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var check: UIImageView!
    
    var delegate: UpdatedDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        totalView.designView()
        check.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        check.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.updated(self)
    }

    
    func update(_ data: Task) {
        taskTitle.text = data.Title
        taskDesc.text = data.Desc
    }
}
