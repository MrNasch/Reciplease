//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Nasch on 20/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import XCTest
import CoreData

@testable import Reciplease

class CoreDataTests: XCTestCase {

    var sut: RecipeStorageManager!
    
    override func setUp() {
        super.setUp()
        sut = RecipeStorageManager(container: mockPersistantContainer)
    }
    // custom managed Object
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    // create mock container
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Reciplease", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
}
