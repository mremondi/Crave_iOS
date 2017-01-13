//
//  TopBarAdapter.swift
//  Crave
//
//  Created by Michael Remondi on 1/5/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import Foundation
import UIKit

class TopBarAdapter {
	var viewController: UIViewController
	init(viewController: UIViewController, title: String?){
		self.viewController = viewController
		setUpTopBar(title: title)
	}
	
	func setUpTopBar(title: String?){
		if (title != nil){
			viewController.navigationItem.title = title
			viewController.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 40)!,  NSForegroundColorAttributeName: UIColor.white]
		}
		else{
			viewController.navigationItem.title = "Crave"
			viewController.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Milkshake", size: 40)!,  NSForegroundColorAttributeName: UIColor.white]
		}
		
		viewController.navigationController?.navigationBar.barTintColor = UIColor(red: 0.737, green: 0.086, blue: 0.212, alpha: 1.0)
		viewController.navigationController?.isNavigationBarHidden = false
		viewController.navigationItem.hidesBackButton = true
		
		viewController.hideKeyboardWhenTappedAround()
		viewController.dismissKeyboard()
	}
}
