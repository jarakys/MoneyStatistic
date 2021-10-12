//
//  DatabaseManager.swift
//  KhNEUTImeTable
//
//  Created by Kirill on 07.03.2020.
//  Copyright © 2020 Kirill. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    private init () {}
    
    private lazy var persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: {(storeDescroption,error) in
            if let error = error as NSError? {
                fatalError("Error")
            }
        })
        return container
    }()
    
    public var context: NSManagedObjectContext {
        get {
            return persistenContainer.viewContext
        }
    }
    
    func createReport(category: Categories?, currency: Currencies?, value: Float) {
        let report = Reports(context: context)
        report.category = category
        report.value = value
        report.uid = UUID()
        report.currency = currency
        report.userId = UUID()
        category?.addToReports(report)
        save()
    }
    
    func getCateogriesFetchController() -> NSFetchedResultsController<Categories> {
        let request: NSFetchRequest<Categories> = Categories.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController<Categories>(
                        fetchRequest: request,
                        managedObjectContext: context,
                        sectionNameKeyPath: nil,
                        cacheName: nil)
        return fetchedResultsController
    }
    
    func getReportsFetchController() -> NSFetchedResultsController<Reports> {
        let request: NSFetchRequest<Reports> = Reports.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController<Reports>(
                        fetchRequest: request,
                        managedObjectContext: context,
                        sectionNameKeyPath: nil,
                        cacheName: nil)
        return fetchedResultsController
    }
    
    public func getBalance() -> Float {
        let earn = getEarn()
        let spent = getSpent()
        return earn - spent
    }
    
    public func getEarn() -> Float {
        let request = NSFetchRequest<NSDictionary>(entityName: "Reports")
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
        expressionDescription.expressionResultType = NSAttributeType.floatAttributeType
        expressionDescription.name = "earned"
        request.propertiesToFetch = [expressionDescription]
        request.predicate = NSPredicate(format: "category.mainCategory == %ld", 1)
        request.returnsObjectsAsFaults = false
        request.resultType = .dictionaryResultType
        let response = try? context.fetch(request)
        if let earned = response?.first?["earned"] as? Float {
            return earned
        }
        return 0
    }
    
    public func getSpent() -> Float {
        let request = NSFetchRequest<NSDictionary>(entityName: "Reports")
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
        expressionDescription.expressionResultType = NSAttributeType.floatAttributeType
        expressionDescription.name = "spent"
        request.propertiesToFetch = [expressionDescription]
        request.predicate = NSPredicate(format: "category.mainCategory == %ld", 2)
        request.returnsObjectsAsFaults = false
        request.resultType = .dictionaryResultType
        let response = try? context.fetch(request)
        if let earned = response?.first?["spent"] as? Float {
            return earned
        }
        return 0
    }
    
    
    
//    public func getDataBy(typeName: String) throws -> [CostData] {
//        let request:NSFetchRequest<CostData> = getRequest()
//        request.predicate = NSPredicate(format: "type.type == %@", typeName)
//        let response = try context.fetch(request)
//        return response
//    }
//    
//    public func getDataBySync(isSynced: Bool) throws -> [CostData] {
//        let request:NSFetchRequest<CostData> = getRequest()
//        request.predicate = NSPredicate(format: "isSynced== %@", isSynced)
//        let response = try context.fetch(request)
//        return response
//    }
//    
//    public func getDataBy(date: Int64) throws -> [CostData] {
//        let request:NSFetchRequest<CostData> = getRequest()
//        request.predicate = NSPredicate(format: "date == %@", date)
//        let response = try context.fetch(request)
//        return response
//    }
//    
//    public func getDataBetweenDate(from: Int64, to: Int64) throws -> [CostData] {
//        let request:NSFetchRequest<CostData> = getRequest()
//        request.predicate = NSPredicate(format: "date >= %@ AND date <= %@", from, to)
//        let response = try context.fetch(request)
//        return response
//    }
//    
//    public func getBalanceBy(date: Int64) throws -> Decimal {
//        let earn = try getEarnBy(date: date)
//        let cost = try getCostBy(date: date)
//        return earn - cost
//    }
//    
//    public func getBalanceBetweenDate(from: Int64, to: Int64) throws -> Decimal {
//        let earn = try getEarnBetweenDate(from: from, to: to)
//        let cost = try getCostBetweenDate(from: from, to: to)
//        return earn - cost
//    }
//    

//    
//    public func getEarnBetweenDate(from: Int64, to: Int64) throws -> Decimal {
//        let request:NSFetchRequest<CostData> = getRequest()
//        request.predicate = NSPredicate(format: "date >= %ld AND date <= %ld AND type.type == %@" , from, to, "Earn")
//        let response = try context.fetch(request)
//        let sum = response.compactMap({$0.sum?.decimalValue}).reduce(0, +)
//        return sum
//    }
//    

//    
//    public func getCostBetweenDate(from: Int64, to: Int64) throws -> Decimal {
//        let request:NSFetchRequest<CostData> = getRequest()
//        request.predicate = NSPredicate(format: "date >= %ld AND date <= %ld AND type.type == %@" , from, to, "Cost")
//        let response = try context.fetch(request)
//        let sum = response.compactMap({$0.sum?.decimalValue}).reduce(0, +)
//        return sum
//    }
    
//    public func getLessonsBySchedule(id: Int64) throws -> [Lessons] {
//        let request:NSFetchRequest<Lessons> = getRequest()
//        request.predicate = NSPredicate(format: "schedule.idEntity == %@", id)
//        let response = try context.fetch(request)
//        return response
//    }
//
//    public func getShedules(idGroupd: Int64, dateUnix: Int64) throws -> [Shedules] {
//        let request:NSFetchRequest<Shedules> = getRequest()
//        request.predicate = NSPredicate(format: "group.idEntity == %@ AND date == %@", idGroupd, dateUnix)
//        let response = try context.fetch(request)
//        return response
//    }
//
//    public func getGroupsBySpecialty(id: Int64) throws -> [Groups] {
//        let request:NSFetchRequest<Groups> = getRequest()
//        request.predicate = NSPredicate(format: "specialty.idEntity == %@", id)
//        let response = try context.fetch(request)
//        return response
//    }
//
//    public func getSpecialtiesByFaculty(id: Int64) throws -> [Specialties] {
//        let request:NSFetchRequest<Specialties> = getRequest()
//        request.predicate = NSPredicate(format: "faculty.idEntity == %@", id)
//        let response = try context.fetch(request)
//        return response
//    }
    
    public func getEntities<T: NSManagedObject>() throws -> [T]{
        let request:NSFetchRequest<T> = getRequest()
        let response = try context.fetch(request)
        return response
    }
    
    private func getRequest<T>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: String(describing: T.self))
    }
    
    public func save() {
        if context.hasChanges {
             try! context.save()
        }
    }
}
