//
//  RestaurantController.swift
//  Crave
//
//  Created by Michael Remondi on 1/7/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RestaurantController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavViewInterface  {
	
	var restaurantID: String?
	var restaurant: Restaurant?
	var menus: [Menu] = []
	
	var buttonMenuMap = [UIButton: Menu]()

	
	@IBOutlet var ivRestaurantLogo: UIImageView!
	@IBOutlet var menuTable: UITableView!
	@IBOutlet var btnDirections: UIButton!
	@IBOutlet var btnPhone: UIButton!
	@IBOutlet var btnWebsite: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)  
		
		self.menuTable.dataSource = self
		self.menuTable.delegate = self
		self.menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
		self.menuTable.reloadData()
		
		requests.requestRestaurantByID(id: restaurantID!, vc: self)
		
		btnDirections.titleEdgeInsets = UIEdgeInsetsMake(0, -btnDirections.imageView!.frame.size.width, 0, btnDirections.imageView!.frame.size.width);
		btnDirections.imageEdgeInsets = UIEdgeInsetsMake(0, btnDirections.frame.size.width - btnDirections.imageView!.frame.size.width, 0, -btnDirections.titleLabel!.frame.size.width);
		
		btnPhone.titleEdgeInsets = UIEdgeInsetsMake(0, -btnPhone.imageView!.frame.size.width, 0, btnPhone.imageView!.frame.size.width);
		btnPhone.imageEdgeInsets = UIEdgeInsetsMake(0, btnPhone.frame.size.width - btnPhone.imageView!.frame.size.width, 0, -btnPhone.titleLabel!.frame.size.width);
		
		btnWebsite.titleEdgeInsets = UIEdgeInsetsMake(0, -btnWebsite.imageView!.frame.size.width, 0, btnWebsite.imageView!.frame.size.width);
		btnWebsite.imageEdgeInsets = UIEdgeInsetsMake(0, btnWebsite.frame.size.width - btnWebsite.imageView!.frame.size.width, 0, -btnWebsite.titleLabel!.frame.size.width);
		

	}
	
	@objc func callNumber() {
		let phoneNumber = restaurant?.getPhoneNumber()
		if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber!)") {
			print("here")
			let application:UIApplication = UIApplication.shared
			if (application.canOpenURL(phoneCallURL as URL)) {
				print("here2")
				application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
			}
		}
	}
	
	@objc func getDirections(){
		let restaurantName = restaurant?.getName().replace(target: " ", withString: "+")
		let qURL = "http://maps.apple.com/?q=" + restaurantName! 
		let llURL = "&ll=" + String(describing: restaurant!.getLat()) + "," + String(describing: restaurant!.getLon())
		let directionsURL = qURL + llURL
		if let url = NSURL(string: directionsURL) {
			UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
		}
	}
	
	@objc func getWebsite(){
		let site = restaurant?.getUrl()
		if let url = NSURL(string: site!) {
			UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.menuTable.dequeueReusableCell(withIdentifier: "menuCell")! as UITableViewCell
		cell.textLabel?.text = self.menus[indexPath.row].getName()
		cell.textLabel?.textAlignment = .center
		cell.isUserInteractionEnabled = true
		
		let button = UIButton()
		button.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.size.width, height: cell.frame.size.height)
		button.addTarget(self, action: #selector(self.menuClick), for: .touchUpInside)
		buttonMenuMap[button] = self.menus[indexPath.row]	
		cell.contentView.addSubview(button)
		
		return cell
	}
	
	func menuClick(sender: UIButton){
		let menu = buttonMenuMap[sender]
		let vc = UIStoryboard(name: "Menu", bundle: nil).instantiateInitialViewController() as? MenuController
		vc?.menu = menu
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.menus.count)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let menu = self.menus[indexPath.row]
		let vc = UIStoryboard(name: "Menu", bundle: nil).instantiateInitialViewController() as? MenuController
		vc?.menu = menu
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
