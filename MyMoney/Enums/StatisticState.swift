//
//  StatisticState.swift
//  MyMoney
//
//  Created by Kirill on 05.03.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import Foundation

enum StatisticState {
    case day
    case week
    case month
    
    var string:String {
        get {
            var value = ""
            switch self {
            case .day:
                value = "День"
            case .week:
                value = "Тиждень"
            case .month:
                value = "Місяць"
            }
            return value
        }
    }
}
