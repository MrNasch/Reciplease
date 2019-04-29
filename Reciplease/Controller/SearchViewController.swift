//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Nasch on 26/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

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
        if ingredientSearchLabel.text != nil {
            ingredientsText.text +=  "\n - \(ingredientSearchLabel.text!)"
        } else {
            print("no item")
        }
    }
}
