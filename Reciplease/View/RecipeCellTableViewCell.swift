//
//  RecipeCellTableViewCell.swift
//  Reciplease
//
//  Created by Nasch on 30/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class RecipeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeDesc: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
