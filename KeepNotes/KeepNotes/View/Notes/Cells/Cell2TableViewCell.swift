//
//  Cell2TableViewCell.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

class Cell2TableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var taskDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        totalView.designView()
    }

    func update(_ data: Task) {
        taskTitle.text = data.Title
        taskDesc.text = data.Desc
    }
}
