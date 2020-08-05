//
//  Settings.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

enum Settings: Int, CaseIterable {
    case logout
    case turnOnOffNotification
    case shareMyAccountWith
    
    var string: String {
        get {
            switch self {
            case .logout:
                return "Вийти"
            case .turnOnOffNotification:
                return "Включити/Вимкнути повідомлення"
            case .shareMyAccountWith:
                return "Поділитіся продуктами для покупки"
            }
        }
    }
    
    var isNeedAuth: Bool {
        get {
            switch self {
            case .turnOnOffNotification, .shareMyAccountWith:
                return true
            default:
                return false
            }
        }
    }
    
    var textColor:UIColor {
        get {
            switch self {
            case .shareMyAccountWith:
                fallthrough
            case .turnOnOffNotification:
                return UIColor(named: "SettingsTextColor")!
            case .logout:
                return .red
            }
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .shareMyAccountWith
        case 1: self = .turnOnOffNotification
        case 2: self = .logout
        default: self = .shareMyAccountWith
        }
    }
    
}
