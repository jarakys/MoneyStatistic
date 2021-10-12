//
//  StatisticCell.swift
//  MyMoney
//
//  Created by Kirill on 29.06.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class StatisticCell: UITableViewCell, ReusableCell {

    @IBOutlet private weak var categoryIndicatorVIew: UIView!
    @IBOutlet private weak var nameCategoryLabel: UILabel!
    @IBOutlet private weak var sumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryIndicatorVIew.layer.cornerRadius = categoryIndicatorVIew.frame.height / 2
        categoryIndicatorVIew.layer.masksToBounds = true

    }
    
    func configure(for report: Reports?) {
        nameCategoryLabel.text = report?.category?.name
        sumLabel.text = report?.value.description
        categoryIndicatorVIew.backgroundColor = .red
    }
}
