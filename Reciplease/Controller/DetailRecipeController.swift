//
//  DetailRecipeController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import CoreData

class DetailRecipeController: UIViewController {

    @IBOutlet weak var recipeDirections: UITextView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var favRecipeTime: UILabel!
    @IBOutlet weak var favRecipeTitle: UILabel!
    @IBOutlet weak var favRecipeImage: UIImageView!
    @IBOutlet weak var favRecipeDirection: UITextView!
    
    var storage = RecipeStorageManager()
    var recipeDetail: Hit!
    var isFavorite: Bool = false
    var recipes: RecipeToSave!
    let request: NSFetchRequest<RecipeToSave> = RecipeToSave.fetchRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let favButton = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favTapped(_:)))
        navigationItem.rightBarButtonItem = favButton
        update()
        updateFav()
    }
    // update screen infos
    func updateFav() {
        guard let recipes = recipes else { return }
        favRecipeTitle.text = recipes.label
        guard let ingredients = recipes.ingredientLines else { return }
        for ingredient in ingredients {
            favRecipeDirection.text += "\(ingredient)"
        }
        favRecipeTime.text = String(recipes.totalTime)
        guard let image = recipes.image else { return }
        let url = URL(string: "\(String(describing: image))")
        favRecipeImage.kf.setImage(with: url)
    }
    func update() {
        guard let recipeDetail = recipeDetail else { return }
        recipeTitle.text = recipeDetail.recipe.label
        for ingredient in recipeDetail.recipe.ingredientLines {
            recipeDirections.text += "- \(ingredient)\n"
        }
        recipeTime.text = String(recipeDetail.recipe.totalTime)
        let url = URL(string: "\(recipeDetail.recipe.image)")
        recipeImage.kf.setImage(with: url)
    }
    
    // sending user to Direction URL
    @IBAction func didTapgetDirectionButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "\(String(describing: recipeDetail.recipe.url))")!)
    }
    @IBAction func getFavRecDir(_ sender: UIButton) {
        guard let url = recipes.url else { return }
        UIApplication.shared.open(URL(string: "\(url)")!)
    }
    
    // Tapped fav button
    @objc func favTapped(_ sender: Any!) {
        if isFavorite2 == true {
            removeFromFav()
        } else {
            addToFav()
            navigationItem.rightBarButtonItem?.tintColor = .green
        }
    }
    
    // Add recipe to Favorite
    func addToFav() {
        recipes = storage.insertRecipe(label: recipeDetail.recipe.label,
                                 url: recipeDetail.recipe.url,
                                 image: recipeDetail.recipe.image,
                                 ingredientLines: recipeDirections.text,
                                 totalTime: recipeDetail.recipe.totalTime)
        print("added fav")

        storage.save()
    }
    // Remove recipe from favorite
    func removeFromFav() {
        storage.remove(recipeID: recipes.objectID)
        print("removed")
        storage.save()
        navigationController?.popViewController(animated: true)
    }
    
    var isFavorite2: Bool {
        return storage.fetchAll().contains(where: { $0.url == self.recipeDetail.recipe.url })
    }
}

// REVOYER UN RECIPETOSAVE EN HIT
//extension RecipeToSave {
//    func toHit() -> Hit {
//        let hit  =
//        return hit
//    }
//}
