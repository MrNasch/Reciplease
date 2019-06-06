//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class FavoritesListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // hidding empty cell
        //tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
}
extension FavoritesListController: UITableViewDataSource {
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.numberOfSections <= 0 {
            // hide tableView and present label TODO
            alerts(title: "ERROR", message: "NO FAV")
            return 0
        } else {
        // table of recipes.count
            return 5
        }
    }
    // get cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as! FavoriteRecipeCellTableViewCell
        return cell
        
    }
    // Height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension FavoritesListController: UITableViewDelegate {
    
}
extension FavoritesListController {
    // alerts
    func alerts(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
