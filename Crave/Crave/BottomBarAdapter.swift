//
//  BottomBarAdapter.swift
//  Crave
//
//  Created by Michael Remondi on 1/4/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import Foundation
import UIKit

public class BottomBarAdapter {
	
	var viewController: UIViewController

	init(viewController: UIViewController){
		self.viewController = viewController
		setUpBar()
	}

	
	func setUpBar(){
		
		let button = UIButton()
		//set image for button
		button.setImage(UIImage(named: "Map"), for: UIControlState())
		//set frame
		button.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
		button.addTarget(viewController, action: #selector(BottomBarAdapter.goToNearMe), for: .touchDown)
		let barButton = UIBarButtonItem(customView: button)
		
		let button2 = UIButton()
		//set image for button
		button2.setImage(UIImage(named: "Search"), for: UIControlState())
		//set frame
		button2.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
		button2.addTarget(viewController, action: #selector(BottomBarAdapter.goToSearch), for: .touchUpInside)
		let barButton2 = UIBarButtonItem(customView: button2)
		
		let button3 = UIButton()
		//set image for button
		button3.setImage(UIImage(named: "Favorites"), for: UIControlState())
		//set frame
		button3.addTarget(viewController, action: #selector(BottomBarAdapter.goToFavorites), for: .touchUpInside)
		button3.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
		let barButton3 = UIBarButtonItem(customView: button3)
		
		let button4 = UIButton()
		//set image for button
		button4.setImage(UIImage(named: "More"), for: UIControlState())
		//set frame
		button4.addTarget(viewController, action: #selector(BottomBarAdapter.goToMore), for: .touchUpInside)
		button4.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
		
		let barButton4 = UIBarButtonItem(customView: button4)
		
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		let navigationBarButtonItemsArray = [barButton, spacer, barButton2,spacer,barButton3,spacer,barButton4]
		
		self.viewController.navigationController?.isToolbarHidden = false
		self.viewController.setToolbarItems(navigationBarButtonItemsArray, animated: true)
		self.viewController.navigationController?.toolbar.barTintColor = UIColor(red: 0.737, green: 0.086, blue: 0.212, alpha: 1.0)
	}
	
	
	@objc func goToSearch(){
		requests.getAllItems()
		
		let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchViewController
		viewController.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	@objc func goToFavorites(){
		
		let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "cravings") as? CravingsViewController
		
		requests.requestUserRatings(id: profile.getID(), vc: vc!)
		
		viewController.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	@objc func goToMore(){
		let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreController
		viewController.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	@objc func goToNearMe(){
		let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
		viewController.navigationController?.pushViewController(vc!, animated: false)
		
	}

}
