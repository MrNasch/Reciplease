//
//  SearchListController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class RecipesListController: UIViewController {
    var recipe = RecipeCellTableViewCell()
    var recipes: Recipes?
    var recipeList = RecipesServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        showRecipesList()
        // hidding empty cell
        //tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
    }
    func showRecipesList() {
        guard let recipes = recipes else { return }
        //recipe.recipeImage.image = URL(fileURLWithPath: recipes.hits[0].recipe.image)
        recipe.recipeTitle.text = recipes.hits[0].recipe.label
        let ingredient = recipes.hits[0].recipe.ingredientLines[1]
        recipe.recipeDesc.text = ingredient
        recipe.recipeTime.text = String(recipes.hits[0].recipe.totalTime)
    }
}
extension RecipesListController: UITableViewDataSource {
    
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table of recipes.count
        if let recipes = recipes {
            return recipes.count.distance(to: 10)
        } else {
            alerts(title: "Error", message: "No recipes Found")
            return 0
        }
    }
    // TODO
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCellTableViewCell
        return cell
        
    }
    // Height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension RecipesListController {
    // alerts
    func alerts(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
