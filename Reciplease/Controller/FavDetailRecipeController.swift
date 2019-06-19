//
//  FavDetailRecipeController.swift
//  Reciplease
//
//  Created by Nasch on 19/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class FavDetailRecipeController: UIViewController {

    var recipes: RecipeToSave!
    
    @IBOutlet weak var favRecipeTime: UILabel!
    @IBOutlet weak var favRecipeTitle: UILabel!
    @IBOutlet weak var favRecipeImage: UIImageView!
    @IBOutlet weak var favRecipeDirection: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getFavRecDir(_ sender: UIButton) {
    }
}
