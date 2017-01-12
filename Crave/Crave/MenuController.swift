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
		self.menuItemTable.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
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
		let cell:UITableViewCell = self.menuItemTable.dequeueReusableCell(withIdentifier: "itemCell")! as UITableViewCell
		cell.textLabel?.text = self.menuSections[indexPath.section].getItems()[indexPath.row].name
		cell.textLabel?.textAlignment = .center
		
		let button = UIButton()
		button.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.size.width, height: cell.frame.size.height)
		button.addTarget(self, action: #selector(self.itemClick), for: .touchUpInside)
		buttonItemMap[button] = self.menuSections[indexPath.section].getItems()[indexPath.row]

		cell.contentView.addSubview(button)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let item = self.menuSections[indexPath.section].getItems()[indexPath.row]
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemController
		vc?.item = item
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func itemClick(sender: UIButton){
		let item = buttonItemMap[sender]
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
