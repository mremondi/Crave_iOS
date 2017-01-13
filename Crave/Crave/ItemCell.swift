//
//  ItemCell.swift
//  Crave
//
//  Created by Michael Remondi on 1/13/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {


	@IBOutlet weak var itemName: UILabel!
	@IBOutlet weak var itemRating: UILabel!
	@IBOutlet weak var itemPrice: UILabel!
	@IBOutlet weak var restaurantName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func formatCell(item: MenuItem){
		
		itemName.text = item.name
		restaurantName.text = item.restaurantName
		
		if (item.rating != "null" && item.numberOfRatings != "null"){
			let rating = Double(item.rating)!
			let numberOfRatings = Double(item.numberOfRatings)!
			var averageRating = 0.0
			if (rating != 0 && numberOfRatings != 0){
				averageRating = rating/numberOfRatings
			}
			if(rating < 1.5){
				itemRating.layer.backgroundColor  =  UIColor.red.cgColor
			}
			else if (rating > 1.5 && rating < 3.5){
				itemRating.layer.backgroundColor  = UIColor.yellow.cgColor
			}
			else{
				itemRating.layer.backgroundColor  = UIColor.green.cgColor
			}
			
			itemRating.text = "\(averageRating)"
		}
		else{
			itemRating.text = "0.0"
		}
		itemRating.layer.masksToBounds = true
		itemRating.layer.cornerRadius = 4
		
		if (item.price != "null"){
			itemPrice.text = "$" + String(format: "%.2f", Double(item.price)!)
		}
		else{
			itemPrice.isHidden = true
		}
	}
}
