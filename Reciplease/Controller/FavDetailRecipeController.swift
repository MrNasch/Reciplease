//
//  FavDetailRecipeController.swift
//  Reciplease
//
//  Created by Nasch on 19/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import CoreData

class FavDetailRecipeController: UIViewController {

    var recipes: RecipeToSave!
    var storage = RecipeStorageManager()
    let favButton = UIBarButtonItem(title: "Remove favorite", style: .plain, target: self, action: #selector(removeFavTapped))
    
    @IBOutlet weak var favRecipeTime: UILabel!
    @IBOutlet weak var favRecipeTitle: UILabel!
    @IBOutlet weak var favRecipeImage: UIImageView!
    @IBOutlet weak var favRecipeDirection: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = favButton
        update()
        
        // Do any additional setup after loading the view.
    }
    // update screen infos
    func update() {
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
    
    @objc func removeFavTapped() {
        removeFromFav()
        storage.save()
    }
    
    // sending user to Direction URL
    @IBAction func getFavRecDir(_ sender: UIButton) {
        guard let url = recipes.url else { return }
        UIApplication.shared.open(URL(string: "\(url)")!)
    }
    
    // Remove recipe from favorite
    func removeFromFav() {
        storage.remove(recipeID: recipes.objectID)
        print("removed")
    }
}
