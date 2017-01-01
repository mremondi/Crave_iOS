//
//  SearchViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate,  UIPickerViewDelegate, UIPickerViewDataSource {
   

    var searchbar = UISearchBar()
    var tableView = UITableView()
    var pickerView = UIPickerView()
    
    var pickerData: [String] = ["Restaurant","Item"]
    
    var data = [""]
    
    
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
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
        
        data = []
        
        for restaurant in nearbyRestaurants.nearbyRestaurants{
            data.append(restaurant.name)
        }
        
        searchbar.frame = CGRect(x: 0, y: 112, width:width, height: 40)
        tableView.frame = CGRect(x: 0, y: 150, width:width, height: height-200)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //registering the cell's class
        self.view.addSubview(searchbar)
        self.view.addSubview(tableView)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        searchbar.delegate = self
        filteredData = data
        
        
        
        
        
        let button = UIView()
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 40)
        
        let buttonImage = UIImageView()
        buttonImage.image = UIImage(named: "Search")
        buttonImage.frame = CGRect(x: 6, y: 0, width: 36-12, height: 22)
        button.addSubview(buttonImage)
        
        let buttonText = UITextView()
        buttonText.text = "Search"
        buttonText.font = UIFont(name: "Helvetica", size: 11)
        buttonText.frame = CGRect(x: -10, y: 20, width: 56, height:20)
        buttonText.backgroundColor = UIColor.red
        buttonText.textColor = UIColor.white
        buttonText.contentInset = UIEdgeInsetsMake(-5.0,0.0,0,0.0)
        buttonText.textAlignment = .center
        button.addSubview(buttonText)
        
        let barButton = UIBarButtonItem(customView: button)
        
        let button2 = UIButton()
        //set image for button
        button2.setImage(UIImage(named: "Map"), for: UIControlState())
        //set frame
        button2.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        button2.addTarget(self, action: #selector(SearchViewController.goToNearMe), for: .touchDown)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        let button3 = UIButton()
        //set image for button
        button3.setImage(UIImage(named: "Favorites"), for: UIControlState())
        //set frame
        button3.addTarget(self, action: #selector(SearchViewController.goToFavorites), for: .touchDown)
        button3.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        let barButton3 = UIBarButtonItem(customView: button3)
        
        let button4 = UIButton()
        //set image for button
        button4.setImage(UIImage(named: "More"), for: UIControlState())
        //set frame
        button4.addTarget(self, action: #selector(SearchViewController.goToMore), for: .touchDown)
        button4.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        
        let barButton4 = UIBarButtonItem(customView: button4)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let navigationBarButtonItemsArray = [barButton2, spacer, barButton,spacer,barButton3,spacer,barButton4]
        
        self.navigationController?.isToolbarHidden = false
        self.setToolbarItems(navigationBarButtonItemsArray, animated: true)
        self.navigationController?.toolbar.barTintColor = UIColor.red

        
        // Do any additional setup after loading the view.
    }
    
    func goToFavorites(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cravings") as? CravingsViewController
        
        requests.requestUserRatings(id: profile.getID(), vc: vc!)
        
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToMore(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreViewController
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.showsCancelButton = false
        searchbar.text = ""
        searchbar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        //print(searchbar.text!)
        searchbar.resignFirstResponder()
        
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        let index = (data.index(of: filteredData[indexPath[1]])!)
        print(data[data.index(of: filteredData[indexPath[1]])!])
        
        if ((pickerData[pickerView.selectedRow(inComponent: 0)]) == "Restaurant"){
            let pickedRestaurant = (nearbyRestaurants.nearbyRestaurants[index])
            
            let id = pickedRestaurant.id
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "restaurant") as? RestaurantViewController
            
            vc?.restID = id
            
            let restaurant = nearbyRestaurants.getRestaurant(id: id)
            
            requests.requestMenu(menuIDs: (restaurant?.getMenus())!, vc: vc!)
            
            //let deadlineTime = DispatchTime.now() + .seconds(3)
            //DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            //VCUtils.hideActivityIndicator(uiView: self.view)
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        
        else if ((pickerData[pickerView.selectedRow(inComponent: 0)]) == "Item"){
            let pickedItem = (curAllItemList[index])
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemViewController
            
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
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
