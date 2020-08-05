//
//  Types+CoreDataClass.swift
//  MyMoney
//
//  Created by Kirill on 17.07.2020.
//  Copyright © 2020 Samax. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Types)
public class Types: NSManagedObject {
     convenience init() {
         // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "Types", in: DatabaseManager.shared.context)
    
         // Создание нового объекта
        self.init(entity: entity!, insertInto: DatabaseManager.shared.context)
     }
}
