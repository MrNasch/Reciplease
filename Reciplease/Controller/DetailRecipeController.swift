//
//  DetailRecipeController.swift
//  Reciplease
//
//  Created by Nasch on 28/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DetailRecipeController: UIViewController {

    @IBOutlet weak var recipeDirections: UITextView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    var recipeDetail: Hit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        update()
    }
    // update screen infos
    func update() {
        guard let recipeDetail = recipeDetail else { return }
        recipeTitle.text = recipeDetail.recipe.label
        for ingredient in recipeDetail.recipe.ingredientLines {
            recipeDirections.text += "\n- \(ingredient)"
        }
        recipeTime.text = String(recipeDetail.recipe.totalTime)
        let url = URL(string: "\(recipeDetail.recipe.image)")
        recipeImage.kf.setImage(with: url)
    }
    
    // sending user to Direction URL
    @IBAction func didTapgetDirectionButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "\(String(describing: recipeDetail.recipe.url))")!)
    }
    
// Item bar
}
