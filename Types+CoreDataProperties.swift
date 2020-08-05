//
//  Types+CoreDataProperties.swift
//  MyMoney
//
//  Created by Kirill on 17.07.2020.
//  Copyright © 2020 Samax. All rights reserved.
//
//

import Foundation
import CoreData


extension Types {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Types> {
        return NSFetchRequest<Types>(entityName: "Types")
    }

    @NSManaged public var type: String?
    @NSManaged public var idType: CostData?

}
