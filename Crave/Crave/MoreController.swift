//
//  MoreController.swift
//  Crave
//
//  Created by Michael Remondi on 1/3/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class MoreController: UIViewController, MoreTransitionDelegate, NavViewInterface{

	@IBOutlet weak var btnProfile: UIButton!
	@IBOutlet weak var btnAboutUs: UIButton!
	
	let margin = CGFloat(20.0);
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		btnProfile.titleEdgeInsets = UIEdgeInsetsMake(0, -btnProfile.imageView!.frame.size.width + margin, 0, btnProfile.imageView!.frame.size.width);
		btnProfile.imageEdgeInsets = UIEdgeInsetsMake(0, btnProfile.frame.size.width - btnProfile.imageView!.frame.size.width - margin, 0, -btnProfile.titleLabel!.frame.size.width);
		
		btnAboutUs.titleEdgeInsets = UIEdgeInsetsMake(0, -btnAboutUs.imageView!.frame.size.width + margin, 0, btnAboutUs.imageView!.frame.size.width);
		btnAboutUs.imageEdgeInsets = UIEdgeInsetsMake(0, btnAboutUs.frame.size.width - btnAboutUs.imageView!.frame.size.width - margin, 0, -btnAboutUs.titleLabel!.frame.size.width);
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func btnProfileClick() {
		let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileController
		self.navigationController?.pushViewController(vc!, animated: false)
	}
    
	@IBAction func btnAboutClick() {
		let vc = UIStoryboard(name: "About", bundle: nil).instantiateInitialViewController() as? AboutUsController
		self.navigationController?.pushViewController(vc!, animated: false)
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
