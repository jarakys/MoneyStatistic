//
//  ReusableCell.swift
//  MyMoney
//
//  Created by Kirill on 29.06.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

protocol ReusableCell {
    static var reusableIndentify: String { get }
    static var nib: UINib { get }
}

extension ReusableCell {
    static var reusableIndentify: String{
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
