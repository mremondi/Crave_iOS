//
//  ItemCell.swift
//  Crave
//
//  Created by Michael Remondi on 1/13/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

	var item: MenuItem?
	
	let redBorder = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
	let greenBorder = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
	let yellowBorder = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)

	
	@IBOutlet weak var itemRating: UILabel!
	@IBOutlet weak var itemPrice: UILabel!
	@IBOutlet weak var itemName: UILabel!
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
				self.layer.addBorder(edge: UIRectEdge.right, color: self.redBorder, thickness: 8)
			}
			else if (rating > 1.5 && rating < 3.5){
				self.layer.addBorder(edge: UIRectEdge.right, color: self.yellowBorder, thickness: 8)
			}
			else{
				self.layer.addBorder(edge: UIRectEdge.right, color: self.greenBorder, thickness: 8)
			}
			
			itemRating.text = String(format: "%.2f", averageRating)
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
	
	func formatCellRating(item: MenuItem, rating: Rating){
		itemName.text = item.name
		restaurantName.text = item.restaurantName
		
		if (rating.rating != "null"){
			let rating = Double(rating.rating)!
			var averageRating = 0.0
			if (rating != 0){
				averageRating = rating
			}
			if(rating < 1.5){
				self.layer.addBorder(edge: UIRectEdge.right, color: self.redBorder, thickness: 8)
			}
			else if (rating > 1.5 && rating < 3.5){
				self.layer.addBorder(edge: UIRectEdge.right, color: self.yellowBorder, thickness: 8)
			}
			else{
				self.layer.addBorder(edge: UIRectEdge.right, color: self.greenBorder, thickness: 8)
			}
			
			itemRating.text = String(format: "%.2f", averageRating)
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

extension CALayer {
	
	func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
		
		let border = CALayer()
		
		switch edge {
		case UIRectEdge.top:
			border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
			break
		case UIRectEdge.bottom:
			border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
			break
		case UIRectEdge.left:
			border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
			break
		case UIRectEdge.right:
			border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
			break
		default:
			break
		}
		
		border.backgroundColor = color.cgColor;
		
		self.addSublayer(border)
	}
}
