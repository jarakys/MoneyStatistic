//
//  State.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

enum Category: Int, CaseIterable {
    case balance
    case earn
    case cost
    
    func color() -> UIColor {
        var colorName = ""
        switch self {
        case .balance:
            colorName = "BalanceColor"
        case .cost:
            colorName = "CostColor"
        case .earn:
            colorName = "EarnColor"
        }
        return UIColor.init(named: colorName)!
    }
    
    var string:String {
        get {
            switch self {
            case .balance:
                return "Баланс"
            case .cost:
                return "Витрати"
            case .earn:
                return "Дохід"
            }
        }
    }
    
    var isEditable: Bool {
        get {
            switch self {
            case .balance:
                return false
            default:
                return true
            }
        }
    }
    
    var image: String {
        get {
            switch self {
            case .balance:
                return "balanceImage"
            case .earn:
                return "earnImage"
            case .cost:
                return "costImage"
            }
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .balance
        case 1: self = .earn
        case 2: self = .cost
        default: self = .balance
        }
    }
    
}
