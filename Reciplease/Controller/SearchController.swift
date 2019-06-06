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
    
    var recipes = NewRecipeService()
    
    
    // Clear Ingredients text
    func clearIngredients() {
        ingredientsText.text = " "
    }
    @IBAction func didTapClear(_ sender: UIButton) {
        clearIngredients()
    }
    // End of clearing Ingredients
    
    // add ingredients to the list
    @IBAction func didTapAdd(_ sender: UIButton) {
        addIngredients()
        ingredientSearchLabel.text = ""
    }
    
    // Add ingredients to the search
    func addIngredients() {
        // Handling Optional
        guard let ingredientSearchLabel = ingredientSearchLabel.text else { return }
        
        if ingredientSearchLabel.isEmpty {
            alerts(title: "Missing Ingredients", message: "No ingredients added")
        } else {
            ingredientsText.text +=  "\n- \(ingredientSearchLabel)"
        }
    }
    
    // get recipes from ingredients
    @IBAction func didTapSearchForRecipes(_ sender: UIButton) {
        guard let listOfIngredients = ingredientsText.text else { return }
        let newListOfIngredients = listOfIngredients.replacingOccurrences(of: "\n ", with: " ")
        toggleActivityIndicator(shown: true)
         self.toggleActivityIndicator(shown: false)
        recipes.getRecipes(query: newListOfIngredients)
        print("ça marche")
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
