//
//  TutorialStep.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import Foundation

enum TutorialStep: Int, CaseIterable {
    case mainDescription
    case statisticDescription
    case createDescription
    
    var description: String {
        get {
            switch self {
            case .mainDescription:
                return "За допомогою цього додатку Ви маєте можливість контролювати свої витрати та дохід"
            case .statisticDescription:
                return "Екран статистики дозволяє Вам проглядати всі Ваші витрати та доходи"
            case .createDescription:
                return "Ви маєте можливість додавати всі витрати та доходи"
            }
        }
    }
    
    var image:String {
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
