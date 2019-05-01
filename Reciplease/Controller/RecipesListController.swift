//
//  SearchListController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class SearchListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // hidding empty cell
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
}
extension SearchListController {
    
    // number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table of recipes.count
        return 3
    }
    // TODO
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCellTableViewCell
        return cell
        
    }
    // Height of the row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension SearchListController {
    // alerts
    func alerts(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
