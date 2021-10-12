//
//  Utils.swift
//  MyMoney
//
//  Created by Kirill on 12.10.2021.
//  Copyright © 2021 Samax. All rights reserved.
//

import Foundation

class Utils {
    static func initDb() {
        let categoriesSpent = ["Автомобіль", "Будинок", "Здоров'я", "Особисті витрати", "Одяг", "Харчування", "Подарунки", "Сімейні витрати", "Техніка", "Послуги", "Розваги", "Подорож", "Комунальні", "Інтернет", "Навчання", "Дорога", "Дати в борг", "Кредит"]
        for (index, item) in categoriesSpent.enumerated() {
            let category = Categories(context: DatabaseManager.shared.context)
            category.uid = UUID() //UUID(uuidString: index.description)
            category.mainCategory = Int32(Category.cost.rawValue)
            category.name = item
        }
        let categoriesEarn = ["Зарплата", "Повернення долгу", "Підзаробіток", "Подарунок", "Інше"]
        for (index, item) in categoriesEarn.enumerated() {
            let category = Categories(context: DatabaseManager.shared.context)
            category.uid = UUID() //UUID(uuidString: index.description)
            category.mainCategory = Int32(Category.earn.rawValue)
            category.name = item
        }
        DatabaseManager.shared.save()
    }
}
