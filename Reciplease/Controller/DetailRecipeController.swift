//
//  DetailRecipeController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Alamofire


class DetailRecipeController: UIViewController {

    @IBOutlet weak var recipeDirections: UITextView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    var recipes: Recipe?
    var recipesServices = NewRecipeService()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func update() {
        guard let recipes = recipes else { return }
        recipeTitle.text = recipes.label
        let ingredient = recipes.ingredientLines[0]
        recipeDirections.text = ingredient
        recipeTime.text = String(recipes.totalTime)
        //recipeImage.image = recipes.image
    }
    
    
    @IBAction func didTapgetDirectionButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "\(String(describing: recipes?.url))")!)
    }
}
