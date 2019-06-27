//
//  Recipes.swift
//  Reciplease
//
//  Created by Nasch on 02/05/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRecipes { response in
//     if let recipes = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire


// MARK: - Recipes
struct Recipes: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseHit { response in
//     if let hit = response.result.value {
//       ...
//     }
//   }

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRecipe { response in
//     if let recipe = response.result.value {
//       ...
//     }
//   }

// MARK: - Recipe
struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let cautions, ingredientLines: [String]
    let totalTime: Int
}



//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseIngredient { response in
//     if let ingredient = response.result.value {
//       ...
//     }
//   }

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
}

