//
//  ViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/15/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The "main" view. This view is the google maps with nearby restaurants.

import UIKit
import GoogleMaps


class NearMeViewController: UIViewController, MapTransitionDelegate, NavViewInterface  {
    
    //The initialized mapView field, created here since it will be used on multiple functions below
    let mapView = MapView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requests.requestNearbyRestaurants(nearbyRestaurants: nearbyRestaurants)
        currentRestaurantMenus.clear()
        
        //General Initializers
        //let width = UIScreen.main.bounds.width
        //let height = UIScreen.main.bounds.height
        mapView.delegate = self
        
        //Listener for updater
        NotificationCenter.default.addObserver(self, selector: #selector(NearMeViewController.drawMap), name:NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)
        
        //Connect the mapView to the biew in the nearMe view controller view
        self.view = mapView.create()
        //self.navigationController?.toolbar.items?.append(barButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //The function that creates the map on the map view view
    func drawMap(){
        mapView.UpdateMap(restaurants: nearbyRestaurants)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The function for transitioning from the nearMe view controller to the restaurant view controller of the clicked on restaurant
    func InfoWindowClicked(id: String) {

        //The view controller variable for the restaurant view controlled
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "restaurant") as? RestaurantController
        
        //Initialize one of the variables of the restaurant view controller
        vc?.restaurantID = id
        
        //Capture the restaurant object of the clicked on restaurant
        _ = nearbyRestaurants.getRestaurant(id: id)
        
        //Call the request for the menus of the restaurant clicked
        //requests.requestMenusByID(menuIDs: (restaurant?.getMenus())!, vc: vc!)

        //Navigate to the restaurant view controller
        self.navigationController?.pushViewController(vc!, animated: false)
        //}
      
    }
	
	func goToSearch(){
		requests.getAllItems()
		
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
}

