//
//  StatisticCell.swift
//  MyMoney
//
//  Created by Kirill on 29.06.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class StatisticCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(icon: String, nameCategory: String, sum: String) {
        self.iconImageView.image = UIImage(named: icon)
        self.nameCategoryLabel.text = nameCategory
        self.sumLabel.text = sum
    }

}
