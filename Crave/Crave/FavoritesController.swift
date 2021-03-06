//
//  FavoritesController.swift
//  Crave
//
//  Created by Michael Remondi on 1/11/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavViewInterface {
	
	var favorites: [MenuItem] = []
	var ratings:[Rating] = []
	
	// This dictonary uses the item id that is in the rating and item to map the correct rating
	var favoritesRatingMap = [String: Rating]()
	
	var buttonFavoriteMap = [UIButton: MenuItem]()

	@IBOutlet weak var favoritesTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)  
		
		self.favoritesTable.dataSource = self
		self.favoritesTable.delegate = self
		self.favoritesTable.register(UINib(nibName: "ItemCellView", bundle: nil), forCellReuseIdentifier: "itemCell")
		self.favoritesTable.reloadData()

    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.favorites.count)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.favoritesTable.dequeueReusableCell(withIdentifier: "itemCell")! as! ItemCell
		
		let item = self.favorites[indexPath.row]
		let rating = self.favoritesRatingMap[item.id]
		
		cell.formatCellRating(item: item, rating: rating!)
		
		
		//cell.formatCellRating(item: self.favorites[indexPath.row], rating: self.ratings[indexPath.row])
		
		// TODO: Make sure you are only getting ratings from the user...
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let item = self.favorites[indexPath.row]
		let vc = UIStoryboard(name: "Item", bundle: nil).instantiateInitialViewController() as? ItemController
		vc?.item = item
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func favoriteClick(sender: UIButton){
		let item = buttonFavoriteMap[sender]
		let vc = UIStoryboard(name: "Item", bundle: nil).instantiateInitialViewController() as? ItemController
		vc?.item = item!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
