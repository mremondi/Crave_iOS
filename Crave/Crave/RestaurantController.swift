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

	
	@IBOutlet weak var ivRestaurantLogo: UIImageView!
	@IBOutlet weak var menuTable: UITableView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//restaurantImageView = UIImageView()
		let _ = TopBarAdapter(viewController: self, title: "Crave")
		let _ = BottomBarAdapter(viewController: self)  
		
		self.menuTable.dataSource = self
		self.menuTable.delegate = self
		self.menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
		self.menuTable.reloadData()
		
		requests.requestRestaurantByID(id: restaurantID!, vc: self)
		
	}


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.menuTable.dequeueReusableCell(withIdentifier: "menuCell")! as UITableViewCell
		cell.textLabel?.text = self.menus[indexPath.row].getName()
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.menus.count)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		print("in click")
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
