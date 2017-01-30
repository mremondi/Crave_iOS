//
//  MenuController.swift
//  Crave
//
//  Created by Michael Remondi on 1/10/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavViewInterface {

	var menu: Menu?
	var menuItems: MenuItem?
	var menuSections: [MenuSection] = []
	var buttonItemMap = [UIButton: MenuItem]()
	
	@IBOutlet var menuItemTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
		let _ = TopBarAdapter(viewController: self, title: (menu?.getName())!)
		let _ = BottomBarAdapter(viewController: self)  
		
		self.menuItemTable.dataSource = self
		self.menuItemTable.delegate = self
		self.menuItemTable.register(UINib(nibName: "ItemCellView", bundle: nil), forCellReuseIdentifier: "itemCell")
		self.menuItemTable.reloadData()
	
		for section in (menu?.getSections())!{
			let menuSection = MenuSection(sectionName: section.getSectionName(), sectionItems: [])
			menuSections.append(menuSection)
			requests.requestMenuItems(menuID: (self.menu?.getID())!, menuSection: menuSection, vc: self)
		}

    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return (menuSections.count)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuSections[section].getItems().count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return menuSections[section].getSectionName()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// the item at this location
		let item = self.menuSections[indexPath.section].getItems()[indexPath.row]

		let cell = self.menuItemTable.dequeueReusableCell(withIdentifier: "itemCell")! as! ItemCell
		cell.formatCell(item: item)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let item = self.menuSections[indexPath.section].getItems()[indexPath.row]
		let vc = UIStoryboard(name: "Item", bundle: nil).instantiateInitialViewController() as? ItemController
		vc?.item = item
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func itemClick(sender: UIButton){
		let item = buttonItemMap[sender]
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
