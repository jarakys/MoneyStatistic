//
//  UIView+BorderLine.swift
//  MyMoney
//
//  Created by Kirill on 01.06.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
enum LinePosition {
    case top
    case bottom
}

extension UIView {
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

}
