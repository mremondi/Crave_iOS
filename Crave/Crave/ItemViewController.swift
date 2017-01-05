//
//  ItemViewController.swift
//  Crave
//
//  Created by Robert Durst on 12/31/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// This is the view for individual food items

import UIKit
import PopupDialog

class ItemViewController: UIViewController, ItemTransitionDelegate, NavViewInterface  {

    let itemView = ItemView()
    var item = MenuItem(id: "", menuID: "", restaurantID: "", name: "", numberOfRatings: "", rating: "", description: "", menuSection: "", price: "", restaurantName: "")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Connect this to the delegate in the ItemView class
        self.itemView.delegate = self
        
        //Set the view controller's view as the view created from the ItemView class
        let view = itemView.create(item: item)
        self.view = view
		
		let _ = BottomBarAdapter(viewController: self)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func TransitionToPopup() {
        showCustomDialog()
    }
   
    //Function that shows the rate a dish popup
    func showCustomDialog() {
        
        // Create a custom view controller
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button (Cancel button) does nothing but close the popup
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            
        }
        
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
		requests.getAllItems()
		
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchViewController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	func goToFavorites(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "cravings") as? CravingsViewController
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

}
