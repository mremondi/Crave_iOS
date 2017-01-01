//
//  ViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/15/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import GoogleMaps


class NearMeViewController: UIViewController, MapTransitionDelegate {
    

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
        
        self.navigationItem.title = "Near Me"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true

        
        let button = UIView()
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 40)
        
        let buttonImage = UIImageView()
        buttonImage.image = UIImage(named: "Map")
        buttonImage.frame = CGRect(x: 6, y: 0, width: 36-12, height: 22)
        button.addSubview(buttonImage)
        
        let buttonText = UITextView()
        buttonText.text = "Near Me"
        buttonText.font = UIFont(name: "Helvetica", size: 11)
        buttonText.frame = CGRect(x: -10, y: 20, width: 56, height:20)
        buttonText.backgroundColor = UIColor.red
        buttonText.textColor = UIColor.white
        buttonText.contentInset = UIEdgeInsetsMake(-5.0,0.0,0,0.0);
        buttonText.textAlignment = .center
        button.addSubview(buttonText)
        
        let barButton = UIBarButtonItem(customView: button)
        
        let button2 = UIButton()
        //set image for button
        button2.setImage(UIImage(named: "Search"), for: UIControlState())
        //set frame
        button2.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        button2.addTarget(self, action: #selector(NearMeViewController.goToSearch), for: .touchDown)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        let button3 = UIButton()
        //set image for button
        button3.setImage(UIImage(named: "Favorites"), for: UIControlState())
        //set frame
        button3.addTarget(self, action: #selector(NearMeViewController.goToFavorites), for: .touchDown)
        button3.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        let barButton3 = UIBarButtonItem(customView: button3)

        
        let button4 = UIButton()
        //set image for button
        button4.setImage(UIImage(named: "More"), for: UIControlState())
        //set frame
        button4.addTarget(self, action: #selector(NearMeViewController.goToMore), for: .touchDown)
        button4.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        
        let barButton4 = UIBarButtonItem(customView: button4)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let navigationBarButtonItemsArray = [barButton, spacer, barButton2,spacer,barButton3,spacer,barButton4]
        
        self.navigationController?.isToolbarHidden = false
        self.setToolbarItems(navigationBarButtonItemsArray, animated: true)
        self.navigationController?.toolbar.barTintColor = UIColor.red
        
        
        self.view = mapView.create()
        //self.navigationController?.toolbar.items?.append(barButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func drawMap(){
        mapView.UpdateMap(restaurants: nearbyRestaurants)
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
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func InfoWindowClicked(id: String) {
        
        //VCUtils.showActivityIndicator(uiView: self.view)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "restaurant") as? RestaurantViewController
        
        vc?.restID = id
        
        let restaurant = nearbyRestaurants.getRestaurant(id: id)
        
        requests.requestMenu(menuIDs: (restaurant?.getMenus())!, vc: vc!)
        
        //let deadlineTime = DispatchTime.now() + .seconds(3)
        //DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            //VCUtils.hideActivityIndicator(uiView: self.view)
        self.navigationController?.pushViewController(vc!, animated: false)
        //}
        
        
        

        
       
    }
    
    
}

