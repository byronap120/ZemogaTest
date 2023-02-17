//
//  CoreDataTestCase.swift
//  ZemogaTestTests
//
//  Created by Byron Ajin on 17/02/23.
//

import XCTest
import CoreData

class CoreDataTestCase: XCTestCase {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var contextTest: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    var contextForTest: NSManagedObjectContext {
        return CoreDataTestCase.contextTest
    }
    
    override func setUp() {
        super.setUp()
        clearData()
    }
    
    override func tearDown() {
        clearData()
        super.tearDown()
    }
    
    func clearData() {
        CoreDataTestCase.contextTest.rollback()
    }
}
