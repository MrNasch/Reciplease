//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Nasch on 26/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var searchForRecipesBurron: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientSearchLabel: UITextField!
    @IBOutlet weak var ingredientsText: UITextView!
    @IBAction func didTapClear(_ sender: UIButton) {
        clearIngredients()
    }
    @IBAction func didTapAdd(_ sender: UIButton) {
        addIngredients()
        ingredientSearchLabel.text = ""
    }
    @IBAction func didTapSearchForRecipes(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        // TODO shared.recipes { (succes, reicpe) in
        // self.toggleActivityIndicator(shown: false)
        // if succes, let recipe = recipe {
        //    self.update(recipe: recipe)
        // } else {
        //    self.alerts(title: "Error", message: "Unable to find recipe")
        //  }
        //}
        print("ça marche")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func clearIngredients() {
        ingredientsText.text = " "
    }
    func addIngredients() {
        // Handling Optional
        guard let ingredientSearchLabel = ingredientSearchLabel.text else { return }
        
        if ingredientSearchLabel.isEmpty {
            alerts(title: "Missing Ingredients", message: "No ingredients added")
        } else {
            ingredientsText.text +=  "\n- \(ingredientSearchLabel)"
        }
    }
}
extension SearchController {
    // activity indicator
    private func toggleActivityIndicator(shown: Bool) {
        searchForRecipesBurron.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    // alerts
    func alerts(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
