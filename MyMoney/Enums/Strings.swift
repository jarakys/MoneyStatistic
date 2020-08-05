//
//  Strings.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import Foundation

enum Strings {
    case mainDescription
    case statisticDescription
    case createDescription
    
    var string: String {
        get {
            switch self {
            case .mainDescription:
                return ""
            case .statisticDescription:
                return ""
            case .createDescription:
                return ""
            }
        }
    }
}
