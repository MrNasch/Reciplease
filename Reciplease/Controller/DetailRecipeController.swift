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
    
    var storage = RecipeStorageManager()
    var recipeDetail: Hit!
    
    var isFavorite: Bool {
        return storage.fetchAll().contains(where: { $0.url == self.recipeDetail.recipe.url })
    }
    let request: NSFetchRequest<RecipeToSave> = RecipeToSave.fetchRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let favButton = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favTapped(_:)))
        navigationItem.rightBarButtonItem = favButton
        update()
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
    
    // Tapped fav button
    @objc func favTapped(_ sender: Any!) {
        if isFavorite == true {
            print("favvv")
            //removeFromFav()
        } else {
            addToFav()
            navigationItem.rightBarButtonItem?.tintColor = .green
        }
    }
    
    // Add recipe to Favorite
    func addToFav() {
        _ = storage.insertRecipe(label: recipeDetail.recipe.label,
                                 url: recipeDetail.recipe.url,
                                 image: recipeDetail.recipe.image,
                                 ingredientLines: recipeDirections.text,
                                 totalTime: recipeDetail.recipe.totalTime)
        print("added fav")

        storage.save()
    }
    // Remove recipe from favorite
//    func removeFromFav() {
//        storage.remove(recipeID: recipes.objectID)
//        print("removed")
//        storage.save()
//        navigationController?.popViewController(animated: true)
//    }
    
    
}
