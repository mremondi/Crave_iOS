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
	var buttonSearchMap = [UIButton: MenuItem]()

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var searchTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let _ = TopBarAdapter(viewController: self, title: ("Cravings"))
		let _ = BottomBarAdapter(viewController: self)  
		
		self.searchBar.delegate = self
		
		self.searchTable.dataSource = self
		self.searchTable.delegate = self
		self.searchTable.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
		self.searchTable.reloadData()
    }
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
		// TODO: Allow filter to be applied
		// Filter codes are:
		// PLH
		// PHL
		// RATING
		requests.requestSearch(query: searchBar.text!, filter: "RATING", vc: self)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.searchItems.count)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.searchTable.dequeueReusableCell(withIdentifier: "searchCell")! as UITableViewCell
		cell.textLabel?.text = self.searchItems[indexPath.row].name
		cell.textLabel?.textAlignment = .center
		
		let button = UIButton()
		button.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.size.width, height: cell.frame.size.height)
		button.addTarget(self, action: #selector(self.searchClick), for: .touchUpInside)
		buttonSearchMap[button] = self.searchItems[indexPath.row]
		
		cell.contentView.addSubview(button)
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
		requests.getAllItems()
		
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchViewController
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
