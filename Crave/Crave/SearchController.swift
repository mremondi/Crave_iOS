//
//  SearchController.swift
//  Crave
//
//  Created by Michael Remondi on 1/12/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, NavViewInterface {
	
	var searchItems: [MenuItem] = []
	var searchRestaurants: [Restaurant] = []
	var buttonSearchMap = [UIButton: MenuItem]()
	
	var searchType = "Items"

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var searchTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)  
		
		self.hideKeyboardWhenTappedAround()
		self.dismissKeyboard()
		
		self.searchBar.delegate = self

		self.searchTable.dataSource = self
		self.searchTable.delegate = self
		self.searchTable.register(UINib(nibName: "ItemCellView", bundle: nil), forCellReuseIdentifier: "itemCell")
		self.searchTable.reloadData()
    }
	
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
		searchItems.removeAll()
		self.searchBar.endEditing(true)
		requests.requestSearch(query: searchBar.text!, filter: "RATING", vc: self)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.searchItems.count)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.searchTable.dequeueReusableCell(withIdentifier: "itemCell")! as! ItemCell
		cell.formatCell(item: self.searchItems[indexPath.row])
		
//		let button = UIButton()
//		button.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.size.width, height: cell.frame.size.height)
//		button.addTarget(self, action: #selector(self.searchClick), for: .touchUpInside)
//		buttonSearchMap[button] = self.searchItems[indexPath.row]
//		
//		cell.contentView.addSubview(button)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let item = self.searchItems[indexPath.row]
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemController
		vc?.item = item
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func searchClick(sender: UIButton){
		let item = buttonSearchMap[sender]
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemController
		vc?.item = item!
		self.navigationController?.pushViewController(vc!, animated: false)
	}

	
	func goToSearch(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchController
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToFavorites(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "favorites") as? FavoritesController
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
