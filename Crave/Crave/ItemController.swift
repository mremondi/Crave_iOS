//
//  ItemController.swift
//  Crave
//
//  Created by Michael Remondi on 1/5/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit
import QuartzCore
import PopupDialog

class ItemController: UIViewController, NavViewInterface {
	
	var item = MenuItem(id: "", menuID: "", restaurantID: "", name: "", numberOfRatings: "", rating: "", description: "", menuSection: "", price: "", restaurantName: "")

	@IBOutlet weak var restaurantNameLabel: UILabel!
	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var tvDescription: UITextView!
	@IBOutlet weak var itemNameLabel: UILabel!
	@IBOutlet weak var ratingLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var btnRate: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)       
		
		restaurantNameLabel.text = item.restaurantName
		tvDescription.text = item.description
		itemNameLabel.text = item.name
		if (item.rating != "null" && item.numberOfRatings != "null"){
			let rating = Double(item.rating)!
			let numberOfRatings = Double(item.numberOfRatings)!
			var averageRating = 0.0
			if (rating != 0 && numberOfRatings != 0){
				averageRating = rating/numberOfRatings
			}
			if(rating < 1.5){
				ratingLabel.layer.backgroundColor  =  UIColor.red.cgColor
			}
			else if (rating > 1.5 && rating < 3.5){
				ratingLabel.layer.backgroundColor  = UIColor.yellow.cgColor
			}
			else{
				ratingLabel.layer.backgroundColor  = UIColor.green.cgColor
			}
			
			ratingLabel.text = String(format: "%.2f", averageRating)
		}
		else{
			ratingLabel.layer.backgroundColor  =  UIColor.red.cgColor
			ratingLabel.text = "0.0"
		}
		ratingLabel.layer.masksToBounds = true
		ratingLabel.layer.cornerRadius = 4
		
		if (item.price != "null"){
			priceLabel.text = "$" + String(format: "%.2f", Double(item.price)!)
		}
		else{
			priceLabel.isHidden = true
		}
		btnRate.addTarget(self, action: #selector(self.showPopUp), for: .touchDown)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(ItemController.restaurantLabelClick))
		restaurantNameLabel.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
	
	func restaurantLabelClick(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "restaurant") as? RestaurantController
		vc?.restaurantID = item.restaurantID
		self.navigationController?.pushViewController(vc!, animated: false)

	}
	
	func showPopUp(){
		// Create a custom view controller
		let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
		
		// Create the dialog
		let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
		
		// Create first button (Cancel button) does nothing but close the popup
		let buttonOne = CancelButton(title: "CANCEL", height: 60) {}
		
		// Create second button (Rate button) sends in a rating and brings the user back to the "main" nearMe view
		let buttonTwo = DefaultButton(title: "RATE", height: 60) {
			//Send in rating
			requests.sendUserRating(itemID: self.item.id, rating: String(ratingVC.cosmosStarRating.rating), userID: profile.getID())
			
			//Send back to view of that restaurant
			let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
			self.navigationController?.pushViewController(vc!, animated: false)
			
			//Alert View about rating success
			let alert = UIAlertController(title: "Successful Rating", message: "Your rating has been recorded. Thank you!", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
		
		// Add buttons to dialog
		popup.addButtons([buttonOne, buttonTwo])
		
		// Present dialog
		present(popup, animated: true, completion: nil)

	}
	
	func goToSearch(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchController
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToFavorites(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "favorites") as? FavoritesController
		requests.requestUserRatings(id: profile.getID(), vc: vc!)
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToMore(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	func goToNearMe(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
