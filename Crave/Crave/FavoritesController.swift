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
	var buttonFavoriteMap = [UIButton: MenuItem]()

	@IBOutlet weak var favoritesTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let _ = TopBarAdapter(viewController: self, title: ("Cravings"))
		let _ = BottomBarAdapter(viewController: self)  
		
		self.favoritesTable.dataSource = self
		self.favoritesTable.delegate = self
		self.favoritesTable.register(UINib(nibName: "ItemCellView", bundle: nil), forCellReuseIdentifier: "itemCell")

		//self.favoritesTable.register(ItemCell.self, forCellReuseIdentifier: "itemCell")
		self.favoritesTable.reloadData()

    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.favorites.count)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.favoritesTable.dequeueReusableCell(withIdentifier: "itemCell")! as! ItemCell
		cell.formatCell(item: self.favorites[indexPath.row])
//		cell.textLabel?.text = self.favorites[indexPath.row].name
//		cell.textLabel?.textAlignment = .center
		
		// TODO: Make sure you are only getting ratings from the user...

		let button = UIButton()
		button.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.size.width, height: cell.frame.size.height)
		button.addTarget(self, action: #selector(self.favoriteClick), for: .touchUpInside)
		buttonFavoriteMap[button] = self.favorites[indexPath.row]
		
		cell.contentView.addSubview(button)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let item = self.favorites[indexPath.row]
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemController
		vc?.item = item
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func favoriteClick(sender: UIButton){
		let item = buttonFavoriteMap[sender]
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
