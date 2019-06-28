//
//  SearchListController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Kingfisher

class RecipesListController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var recipes: Recipes!
    
    // reload tableViewData
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
extension RecipesListController: UITableViewDataSource, UITableViewDelegate {
    // number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table of recipes.count
            return recipes.hits.count
    }
    // data in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCellTableViewCell else {
            return UITableViewCell()
        }
        // Create recipe at the index
        let recipe = recipes.hits[indexPath.row]

        cell.recipeTitle.text = recipe.recipe.label
        cell.recipeTime.text = String(recipe.recipe.totalTime)
        cell.recipeDesc.text = recipe.recipe.ingredientLines[0]
        let url = URL(string: "\(recipe.recipe.image)")
        cell.recipeImage.kf.indicatorType = .activity
        cell.recipeImage.kf.setImage(with: url)
        return cell
    }
    
    // Height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // segue to detail with selectedRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes.hits[indexPath.row]
        self.performSegue(withIdentifier: "recipeToDetail", sender: recipe)
    }
}

extension RecipesListController {
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeToDetail" {
            let recipesDetailVC = segue.destination as! DetailRecipeController
            recipesDetailVC.recipeDetail = sender as? Hit
        }
    }
    // alerts
    func alerts(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
