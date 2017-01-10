//
//  SearchViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The view that allows for the user to search for a specific restaurant or menu item and view that restaurant/menu item. Right now, the user is able to search nearby restaurants, or all food items.

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate,  UIPickerViewDelegate, UIPickerViewDataSource, NavViewInterface {
   
    //Initial the necessary elements of the view
    var searchbar = UISearchBar()
    var tableView = UITableView()
    var pickerView = UIPickerView()
    
    //Initialize the two categories that the user may search for. These categories are in the picker view.
    var pickerData: [String] = ["Restaurant","Item"]
    
    //Initialize the data. This data will be loaded later so "" is a placeholder essentially.
    var data = [""]
    
    //This secondary data array is used by the search bar to show the shortened array based on the text in the search bar.
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //These initialize properties of the view, setting the title, the title format, the color of the navigation bar, hiding the nav bar back button, and making sure the nav bar is not hidden
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        //General initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        //Create the UIPickerView
        //Input data into the Array:
        pickerData = ["Restaurant","Item"]
        //Connect the data
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        pickerView.frame = CGRect(x: width/2, y: 62, width:width/2, height: 60)
        self.view.addSubview(pickerView)
        
        //Label to indicate what the person is searching for
        let searchForLabel = UILabel(frame: CGRect(x: 5, y: 62, width:width/2, height: 60))
        searchForLabel.text = "Searching For: "
        searchForLabel.textColor = UIColor.black
        searchForLabel.textAlignment = .left
        searchForLabel.font = UIFont(name: "Helvetica", size: 20)
        self.view.addSubview(searchForLabel)
        
        //Empty the array then put in the restaurant data since the restaurant is the search category by default
        data = []
        for restaurant in nearbyRestaurants.nearbyRestaurants{
            data.append(restaurant.name)
        }
        
        //Adjust the chracteristics of the search bar and the tableview including connecting the relevant delegates
        searchbar.frame = CGRect(x: 0, y: 112, width:width, height: 40)
        tableView.frame = CGRect(x: 0, y: 150, width:width, height: height-200)
        tableView.dataSource = self
        tableView.delegate = self
        searchbar.delegate = self
        filteredData = data
        
        //Register the cell's class
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Add the tableview and the searchbar to the main view
        self.view.addSubview(searchbar)
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
    
    //The function that unhides the cancel button if the user begins typing in the search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = true
    }
    
    //The function that hides the keyboard, hides the cancel button, and sets the text in the search bar to empty if the user hits the cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.showsCancelButton = false
        searchbar.text = ""
        searchbar.resignFirstResponder()
    }
    
    //The function that creates the tableview cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    //The function that dictates the number of rows per section (we have just one section)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    //The function that hides the keyboard when the search button is tapped
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        searchbar.resignFirstResponder()
        
    }

    //The function that deals with the transition from the search view controller to either the restaurant or menu item view vontroller depending on the selected category in the picker view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //Adjust the index of the filtered data to the index of the unfiltered data
        let index = (data.index(of: filteredData[indexPath[1]])!)
        
        //If the category selected in the picker view is restaurant (works very similar to the transition from nearMe view controller to the restaurant view controller)
        if ((pickerData[pickerView.selectedRow(inComponent: 0)]) == "Restaurant"){
            let pickedRestaurant = (nearbyRestaurants.nearbyRestaurants[index])
            
            let id = pickedRestaurant.id
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "restaurant") as? RestaurantViewController
            
            vc?.restID = id
            
            let restaurant = nearbyRestaurants.getRestaurant(id: id)
            
            requests.requestMenu(menuIDs: (restaurant?.getMenus())!, vc: vc!)

            self.navigationController?.pushViewController(vc!, animated: false)
        }
        
        //If the category selected in the picker view is item (works very similar to the transition from either the menu view controller or the cravings view controller to the menu item view controller)
        else if ((pickerData[pickerView.selectedRow(inComponent: 0)]) == "Item"){
            let pickedItem = (curAllItemList[index])
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemController
            
            vc?.title = pickedItem.name
            vc?.item = pickedItem
            
            self.navigationController?.pushViewController(vc!, animated: false)
            
        }
        
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerData[row] == "Item"){
            data = []
            for item in curAllItemList{
                data.append(item.name)
            }
            filteredData = data
            tableView.reloadData()
        }
        
        else if (pickerData[row] == "Restaurant"){
            data = []
            for restaurant in nearbyRestaurants.nearbyRestaurants{
                data.append(restaurant.name)
            }
            filteredData = data
            tableView.reloadData()
        }
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //I believe this is the same as the above function, but the code only worked if I had both
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
	}

}
