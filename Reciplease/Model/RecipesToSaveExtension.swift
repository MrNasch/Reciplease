//
//  RecipesToSaveExtension.swift
//  Reciplease
//
//  Created by Nasch on 28/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
import CoreData


extension RecipeToSave {
    
    
    func toHit() -> Hit {
        
        let hit = Hit(recipe: Recipe(label: label ?? "" , image: image ?? "", url: url ?? "", cautions: [], ingredientLines: [ingredientLines ?? ""], totalTime: Int(totalTime )))
        
        return hit
    }
    
}
