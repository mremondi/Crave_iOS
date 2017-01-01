//
//  ItemViewController.swift
//  Crave
//
//  Created by Robert Durst on 12/31/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import PopupDialog

class ItemViewController: UIViewController, ItemTransitionDelegate {

    let itemView = ItemView()
    var item = MenuItem(id: "", menuID: "", restaurantID: "", name: "", numberOfRatings: "", rating: "", description: "", menuSection: "", price: "", restaurantName: "")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        self.itemView.delegate = self
        
        let view = itemView.create(item: item)
        
        self.view = view
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func TransitionToPopup() {
        showCustomDialog()
    }
   
    func showCustomDialog() {
        
        // Create a custom view controller
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            
        }
        
        // Create second button
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
