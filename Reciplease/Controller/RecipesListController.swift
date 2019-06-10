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
    
    var recipes: Recipes!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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
            return recipes.count
    }
    // TODO
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCellTableViewCell
        cell.recipeTitle.text = recipes.hits[0].recipe.label
        cell.recipeTime.text = String(recipes.hits[0].recipe.totalTime)
        cell.recipeDesc.text = recipes.hits[0].recipe.ingredientLines[0]
        let imageUrlString = "\(recipes.hits[0].recipe.image)"
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        cell.recipeImage.image = image
        //cell.recipeImage.image = recipes.hits[0].recipe.image.toImage()
        print(recipes.count)
        //print(recipes!)
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
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
