//
//  CategoryCell.swift
//  MyMoney
//
//  Created by Kirill on 10.10.2021.
//  Copyright © 2021 Samax. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, ReusableCell {
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
        indicatorView.layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(mainCategory: Category, text: String) {
        indicatorView.backgroundColor = mainCategory.color()
        nameLabel.text = text
    }
}
