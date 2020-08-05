//
//  UIView+AddShadow.swift
//  MyMoney
//
//  Created by Kirill on 31.05.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, rect: CGRect, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 2.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), rect: rect, color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -1), rect: rect, color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, rect: CGRect, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 20).cgPath
        self.layer.shadowRadius = radius
    }
    
//    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
//        layer.masksToBounds = false
//        layer.shadowOffset = offset
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = radius
//        layer.shadowOpacity = opacity
//
//        let backgroundCGColor = backgroundColor?.cgColor
//        backgroundColor = nil
//        layer.backgroundColor =  backgroundCGColor
//    }
}
