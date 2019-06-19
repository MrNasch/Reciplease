//
//  FavoriteRecipeCellTableViewCell.swift
//  Reciplease
//
//  Created by Nasch on 30/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class FavoriteRecipeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeFavTime: UILabel!
    @IBOutlet weak var recipeFavImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
