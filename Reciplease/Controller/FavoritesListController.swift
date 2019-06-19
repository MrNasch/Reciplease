//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class FavoritesListController: UIViewController {
    
    var storage = RecipeStorageManager()
    var recipes: RecipeToSave!
    let request: NSFetchRequest<RecipeToSave> = RecipeToSave.fetchRequest()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hidding empty cell
        //tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
}
extension FavoritesListController: UITableViewDataSource, UITableViewDelegate {
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let recipesSaved = try? storage.backgroundContext.fetch(request) else { return 1 }
        
        if tableView.numberOfSections <= 0 {
            // hide tableView and present label TODO
            alerts(title: "ERROR", message: "NO FAV")
            return 0
        } else {
        // table of recipes.count
            return recipesSaved.count
        }
    }
    // get cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as! FavoriteRecipeCellTableViewCell
        
        guard let recipesSaved = try? storage.backgroundContext.fetch(request) else { return UITableViewCell() }
        
        let recipe = recipesSaved[indexPath.row]
        
        cell.recipeLabel.text = recipe.label
        cell.recipeDescription.text = recipe.ingredientLines
        cell.recipeFavTime.text = String(recipe.totalTime)
        cell.recipeFavImage.kf.indicatorType = .activity
        cell.recipeFavImage.kf.setImage(with: URL(string: recipe.image!))
        
        
        
        return cell
    }
    // Height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // segue to detail with selectedRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipesSaved = try? storage.backgroundContext.fetch(request) else { return }
        let recipe = recipesSaved[indexPath.row]
        self.performSegue(withIdentifier: "recipeFavDetail", sender: recipe)
    }
}
extension FavoritesListController {
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeFavDetail" {
            let favRecipeDetailVC = segue.destination as! FavDetailRecipeController
            favRecipeDetailVC.recipes = sender as? RecipeToSave
        }
    }
    // alerts
    func alerts(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
