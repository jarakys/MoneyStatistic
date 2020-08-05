//
//  Subcategories+CoreDataProperties.swift
//  MyMoney
//
//  Created by Kirill on 17.07.2020.
//  Copyright © 2020 Samax. All rights reserved.
//
//

import Foundation
import CoreData


extension Subcategories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subcategories> {
        return NSFetchRequest<Subcategories>(entityName: "Subcategories")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageBytes: Data?
    @NSManaged public var subcategory: CostData?

}
