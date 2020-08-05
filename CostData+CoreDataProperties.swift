//
//  CostData+CoreDataProperties.swift
//  MyMoney
//
//  Created by Kirill on 17.07.2020.
//  Copyright © 2020 Samax. All rights reserved.
//
//

import Foundation
import CoreData


extension CostData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CostData> {
        return NSFetchRequest<CostData>(entityName: "CostData")
    }

    @NSManaged public var date: Int64
    @NSManaged public var isSynced: Bool
    @NSManaged public var sum: NSDecimalNumber?
    @NSManaged public var type: Types?
    @NSManaged public var subcategory: Subcategories?

}
