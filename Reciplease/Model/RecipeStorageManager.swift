//
//  RecipeStorageManager.swift
//  Reciplease
//
//  Created by Nasch on 18/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecipeStorageManager {
    
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    let persistentContainer: NSPersistentContainer!
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        //use default container for prod
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    func insertRecipe(label: String, url: String, image: String, ingredientLines: String, totalTime: Int ) -> RecipeToSave? {
        guard let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: backgroundContext) as? RecipeToSave else { return nil }
        recipe.label = label
        recipe.image = image
        recipe.ingredientLines = ingredientLines
        recipe.totalTime = Int16(totalTime)
        recipe.url = url
        return recipe
    }
    
    func fetchAll() -> [RecipeToSave] {
        let request: NSFetchRequest<RecipeToSave> = RecipeToSave.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [RecipeToSave]()
    }
    
    func remove(recipeID: NSManagedObjectID) {
        let rec = backgroundContext.object(with: recipeID)
        backgroundContext.delete(rec)
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
}
