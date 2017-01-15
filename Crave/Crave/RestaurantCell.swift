//
//  RestaurantCell.swift
//  Crave
//
//  Created by Michael Remondi on 1/15/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

	@IBOutlet weak var restaurantNameLabel: UILabel!
	@IBOutlet weak var ivRestaurantLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func formatCell(restaurant: Restaurant){
		restaurantNameLabel.text = restaurant.name
		ivRestaurantLogo.downloadedFrom(link: restaurant.getPhotoURL())
	}
	
}
