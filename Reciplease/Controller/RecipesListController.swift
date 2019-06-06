//
//  SearchListController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class RecipesListController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var recipe = RecipeCellTableViewCell()
    var recipeList = NewRecipeService()
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        recipeList.getRecipes(query: "") { (recipes, error) in
//            print(recipes)
//            print(error)
//        }
        // hidding empty cell
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
}
extension RecipesListController: UITableViewDataSource {
    
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table of recipes.count
        //if let recipes = recipes {
            return recipes.count.distance(to: 5)
//        } else {
//            alerts(title: "Error", message: "No recipes Found")
//            return 1
//        }
    }
    // TODO
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCellTableViewCell
        //cell.recipeTitle.text = recipes[indexPath.row].label
        return cell
        
    }
    // Height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//Delegate Table
extension RecipesListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
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
