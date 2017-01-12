//
//  AboutUsController.swift
//  Crave
//
//  Created by Michael Remondi on 1/5/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class AboutUsController: UIViewController, NavViewInterface {

	@IBOutlet weak var tvEmail: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        tvEmail.isEditable = false
		
		let _ = TopBarAdapter(viewController: self, title: "Crave")
		let _ = BottomBarAdapter(viewController: self)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

	
	
}
