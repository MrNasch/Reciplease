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

class DetailRecipeController: UIViewController {

    @IBOutlet weak var recipeDirections: UITextView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    var recipeDetail: Hit!
    var isFavorite: Bool = false
    let favButton = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = favButton
        update()
    }
    // update screen infos
    func update() {
        guard let recipeDetail = recipeDetail else { return }
        recipeTitle.text = recipeDetail.recipe.label
        for ingredient in recipeDetail.recipe.ingredientLines {
            recipeDirections.text += "\n- \(ingredient)"
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
    @objc func favTapped() {
        if isFavorite {
            favButton.title = "Remove from favorite"
        } else {
            
        }
    }
    
    // Add recipe to Favorite
    func addToFav() {
        
    }
    
    // Remove recipe from favorite
    func removeFromFav() {
        
    }
}
