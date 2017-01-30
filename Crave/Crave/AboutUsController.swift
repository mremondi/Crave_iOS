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
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	func goToSearch(){
        let vc = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as? SearchController
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToFavorites(){
		let vc = UIStoryboard(name: "Favorites", bundle: nil).instantiateInitialViewController() as? FavoritesController
		requests.requestUserRatings(id: profile.getID(), vc: vc!)
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToMore(){
		let vc = UIStoryboard(name: "More", bundle: nil).instantiateInitialViewController() as? MoreController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	func goToNearMe(){
		let vc = UIStoryboard(name: "NearMe", bundle: nil).instantiateInitialViewController() as? NearMeViewController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}

	
	
}
