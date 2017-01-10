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

	
	@IBOutlet var ivRestaurantLogo: UIImageView!
	@IBOutlet var menuTable: UITableView!
	@IBOutlet weak var btnDirections: UIButton!
	@IBOutlet weak var btnPhone: UIButton!
	@IBOutlet weak var btnWebsite: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let _ = TopBarAdapter(viewController: self, title: "Crave")
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
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.menuTable.dequeueReusableCell(withIdentifier: "menuCell")! as UITableViewCell
		cell.textLabel?.text = self.menus[indexPath.row].getName()
		cell.textLabel?.textAlignment = .center
		cell.isUserInteractionEnabled = true
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.menus.count)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let menu = self.menus[indexPath.row]
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as? MenuController
		vc?.menu = menu
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
