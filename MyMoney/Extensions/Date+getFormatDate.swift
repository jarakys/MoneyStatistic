//
//  Date+getFormatDate.swift
//  MyMoney
//
//  Created by Kirill on 17.07.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import Foundation

extension Date {
    func getFormatDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
