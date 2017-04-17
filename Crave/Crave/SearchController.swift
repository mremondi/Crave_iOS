//
//  SearchController.swift
//  Crave
//
//  Created by Michael Remondi on 1/12/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, NavViewInterface {
	
	let ITEM_SCOPE_TAG = "Items"
	let RESTAURANT_SCOPE_TAG = "Restaurants"
	var currentScope: String = ""
	
	var searchItems: [MenuItem] = []
	var searchRestaurants: [Restaurant] = []
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var searchTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)  
		
		self.hideKeyboardWhenTappedAround()
		self.dismissKeyboard()
		
		self.searchBar.delegate = self
		searchBar.placeholder = "Enter any meal name or food description"
		self.searchBar.scopeButtonTitles = [self.ITEM_SCOPE_TAG, self.RESTAURANT_SCOPE_TAG]
		self.currentScope = ITEM_SCOPE_TAG
		self.searchTable.dataSource = self
		self.searchTable.delegate = self
		self.searchTable.register(UINib(nibName: "ItemCellView", bundle: nil), forCellReuseIdentifier: "itemCell")
		self.searchTable.register(UINib(nibName: "RestaurantCellView", bundle: nil), forCellReuseIdentifier: "restaurantCell")
		self.searchTable.reloadData()
	}	
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
		searchItems.removeAll()
		searchRestaurants.removeAll()
		searchTable.reloadData()
		self.searchBar.endEditing(true)
		if (currentScope == self.ITEM_SCOPE_TAG){
			requests.requestSearch(query: searchBar.text!, filter: "RATING", vc: self)
		}
		else{
			requests.requestSearchRestaurants(query: searchBar.text!, vc: self)
		}
	}
	
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		self.currentScope = (searchBar.scopeButtonTitles?[selectedScope])!
		if (self.currentScope == self.RESTAURANT_SCOPE_TAG){
			searchBar.placeholder = "Enter a restaurant name or cuisine type"
		}
		else{
			searchBar.placeholder = "Enter any meal name or food description"
		}
		self.searchBar.text = ""
		self.searchItems = []
		self.searchRestaurants = []
		self.searchTable.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (self.currentScope == self.ITEM_SCOPE_TAG){
			return self.searchItems.count
		}
		else{
			return self.searchRestaurants.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if (self.currentScope == self.ITEM_SCOPE_TAG){
			let cell = self.searchTable.dequeueReusableCell(withIdentifier: "itemCell")! as! ItemCell
			cell.formatCell(item: self.searchItems[indexPath.row])
			return cell
		}
		else{
			let cell = self.searchTable.dequeueReusableCell(withIdentifier: "restaurantCell")! as! RestaurantCell
			cell.formatCell(restaurant: self.searchRestaurants[indexPath.row])
			return cell
		}
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		if(self.currentScope == self.ITEM_SCOPE_TAG){
			let item = self.searchItems[indexPath.row]
			let vc = UIStoryboard(name: "Item", bundle: nil).instantiateInitialViewController() as? ItemController
			vc?.item = item
			self.navigationController?.pushViewController(vc!, animated: false)
			return
		}
		else{
			let restaurant = self.searchRestaurants[indexPath.row]
			let vc = UIStoryboard(name: "Restaurant", bundle: nil).instantiateInitialViewController() as? RestaurantController
			vc?.restaurantID = restaurant.getId()
			self.navigationController?.pushViewController(vc!, animated: false)
			return 
		}
		
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
