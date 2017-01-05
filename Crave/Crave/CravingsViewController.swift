//
//  FavoritesViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The view that displays the previous ratings, or cravings, of the user. The user may click on these ratings and see the overall rating of the menu items and may also see other various details of the menu item objects.

import UIKit

class CravingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , NavViewInterface {

    //The tableview is the main view of this view controller
    let tableView = UITableView()
    
    //These are data fields that will be filled once the API call finishes. I create them as global variables within this class so that it is easiest to reference these variables from functions outside this class.
    var ratingData:[Rating] = []
    var data: [MenuItem] = []
    var filteredData: [MenuItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //These initialize properties of the view, setting the title, the title format, the color of the navigation bar, hiding the nav bar back button, and making sure the nav bar is not hidden
        self.navigationItem.title = "Your Cravings"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Create the table view for all of the user's rated items
        tableView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //registering the cell's class
        tableView.dataSource = self
        tableView.delegate = self
        filteredData = data
        self.view.addSubview(tableView)
        
        let _ = BottomBarAdapter(viewController: self)
		
        // Do any additional setup after loading the view.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function creates the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        //The name of the item
        let cellItemTitleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: cell.bounds.width-10, height: (cell.bounds.height/2-10)))
        cellItemTitleLabel.text = filteredData[indexPath.row].name
        cellItemTitleLabel.textColor = UIColor.darkGray
        cellItemTitleLabel.font = UIFont(name: "Helvetica", size: 12)
        cellItemTitleLabel.textAlignment = .left
        cell.addSubview(cellItemTitleLabel)
        
        //The rating (user's rating) and the price of the item
        let cellItemPriceAndRatingLabel = UILabel(frame: CGRect(x: 10, y: 10, width: cell.bounds.width-20, height: (cell.bounds.height/2-10)))
        var ratingValue = Double(filteredData[indexPath.row].rating)!/Double(filteredData[indexPath.row].numberOfRatings)!
        if (ratingValue > 5.0){
            ratingValue = ratingValue/2
        }
        cellItemPriceAndRatingLabel.text = "Price: $" + String(format: "%.2f", Double(filteredData[indexPath.row].price)!) + " Rating: " + String(format: "%.2f", ratingValue)
        cellItemPriceAndRatingLabel.textColor = UIColor.darkGray
        cellItemPriceAndRatingLabel.font = UIFont(name: "Helvetica", size: 12)
        cellItemPriceAndRatingLabel.textAlignment = .right
        cell.addSubview(cellItemPriceAndRatingLabel)
        
        //The title of the restaurant
        let cellRestaurantTitleLabel = UILabel(frame: CGRect(x: (10), y: (10+cell.bounds.height/2-10), width: cell.bounds.width-10, height: (cell.bounds.height/2-10)))
        cellRestaurantTitleLabel.text = filteredData[indexPath.row].restaurantName
        cellRestaurantTitleLabel.textColor = UIColor.darkGray
        cellRestaurantTitleLabel.font = UIFont(name: "Helvetica", size: 12)
        cellRestaurantTitleLabel.textAlignment = .left
        cell.addSubview(cellRestaurantTitleLabel)
        
        return cell
    }
    
    //This function returns the number of rows in each section (we only have one section)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    //This function deaals with user interaction with the table. It transitions from the selected tabel row to the corresponding item view controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        //Get the selected menu item object
        let curItem = data[indexPath[1]]
        
        //Initialize the view controller for menu items
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemViewController
        
        //Initialize a few of the variables of the view controller
        vc?.title = curItem.name
        vc?.item = curItem
        
        //Navigate to the menu item view controller
        self.navigationController?.pushViewController(vc!, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
