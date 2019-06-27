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

    // SETUP
    var sut: RecipeStorageManager!
    
    // custom managed Object
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
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
    
    // setting up the fake datas
    override func setUp() {
        super.setUp()
        
        initStubs()
        
        sut = RecipeStorageManager(container: mockPersistantContainer)
        
        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
    }
    
    // Clear all stubs
    override func tearDown() {
        NotificationCenter.default.removeObserver(self)
        
        flushData()
        
        
        super.tearDown()
    }
    // Creat observer  to check if context saved
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }
    // waiting notification
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    // notification to say that the context is saved
    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }

    // Initialize fake recipes
    func initStubs() {
        
        func insertRecipe(label: String, url: String, image: String, ingredientLines: String, totalTime: Int ) -> RecipeToSave? {
            guard let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: mockPersistantContainer.viewContext) as? RecipeToSave else { return nil }
            
            recipe.setValue(label, forKey: "label")
            recipe.setValue(url, forKey: "url")
            recipe.setValue(image, forKey: "image")
            recipe.setValue(ingredientLines, forKey: "ingredientLines")
            recipe.setValue(totalTime, forKey: "totalTime")
            
            return recipe
        }
        
        _ = insertRecipe(label: "1", url: "1", image: "1", ingredientLines: "1", totalTime: 1)
        _ = insertRecipe(label: "2", url: "2", image: "2", ingredientLines: "2", totalTime: 2)
        _ = insertRecipe(label: "3", url: "3", image: "3", ingredientLines: "3", totalTime: 3)
        
        
        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }
    }
    
    // Fetch data
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let recipes = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let recipe as NSManagedObject in recipes {
            mockPersistantContainer.viewContext.delete(recipe)
        }
        try! mockPersistantContainer.viewContext.save()
    }
    
    //Convenient method for getting the number of data in store now
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
        let results = try! mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }
    
    
    
    
    // MARK: TEST
    
    func testInsertRecipe_to_data() {
    //Given
        let label = "4"
        let url = "4"
        let image = "4"
        let ingredientLines = "4"
        let totalTime = 4
    //When
        let rec = sut.insertRecipe(label: label, url: url, image: image, ingredientLines: ingredientLines, totalTime: totalTime)
    //Then
        XCTAssertNotNil(rec)
    }

    func testFetch_Recipe_FromCore() {
        //Given
        if let testManager = self.sut {
            //When
            let results = testManager.fetchAll()
            //Then
            XCTAssertEqual(results.count, 3)
        } else {
            XCTFail()
        }
    }

    func testRemove_recipe_fromData() {
    //Given
        let items = sut.fetchAll()
        let item = items[0]

        let numberOfItems = items.count
    //When
        sut.remove(recipeID: item.objectID)
        sut.save()
    //Then
        XCTAssertEqual(numberOfItemsInPersistentStore(), numberOfItems - 1)
    }
    
    func test_save() {
        
        //Give a todo item
        let label = "4"
        let url = "4"
        let image = "4"
        let ingredientLines = "4"
        let totalTime = 4
        
        _ = expectationForSaveNotification()
        
        _ = sut.insertRecipe(label: label, url: url, image: image, ingredientLines: ingredientLines, totalTime: totalTime)
        
        //When save
        
        
        //Assert save is called via notification (wait)
        expectation(forNotification: NSNotification.Name(rawValue: Notification.Name.NSManagedObjectContextDidSave.rawValue), object: nil, handler: nil)
        
        sut.save()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        
    }

}
