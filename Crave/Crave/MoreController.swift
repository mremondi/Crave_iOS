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
		
		let _ = BottomBarAdapter(viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func btnProfileClick() {
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileController
		self.navigationController?.pushViewController(vc!, animated: false)
	}
    
	@IBAction func btnAboutClick() {
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "aboutUs") as? AboutUsController
		self.navigationController?.pushViewController(vc!, animated: false)
		
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
