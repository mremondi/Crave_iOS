//
//  ViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/15/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import GoogleMaps

class NearMeViewController: UIViewController {
    
    let nearbyRestaurants = NearbyRestaurants()
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let requests = Requests()
        requests.callRequest(nearbyRestaurants: nearbyRestaurants)
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        //Listener for updater
        NotificationCenter.default.addObserver(self, selector: #selector(NearMeViewController.drawMap), name:NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
        
        self.navigationItem.title = "Near Me"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        let button = UIButton()
        //set image for button
        button.setImage(UIImage(named: "map"), for: UIControlState())
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 34, height: 33)
        button.addTarget(self, action: #selector(NearMeViewController.goToNearMe), for: .touchDown)
        let barButton = UIBarButtonItem(customView: button)
        
        let button2 = UIButton()
        //set image for button
        button2.setImage(UIImage(named: "profile"), for: UIControlState())
        //set frame
        button2.frame = CGRect(x: 0, y: 0, width: 34, height: 33)
        button2.addTarget(self, action: #selector(NearMeViewController.goToProfile), for: .touchDown)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        let button3 = UIButton()
        //set image for button
        button3.setImage(UIImage(named: "search"), for: UIControlState())
        //set frame
        button3.addTarget(self, action: #selector(NearMeViewController.goToSearch), for: .touchDown)
        button3.frame = CGRect(x: 0, y: 0, width: 34, height: 33)
        let barButton3 = UIBarButtonItem(customView: button3)
        
        let button4 = UIButton()
        //set image for button
        button4.setImage(UIImage(named: "star"), for: UIControlState())
        //set frame
        button4.addTarget(self, action: #selector(NearMeViewController.goToFavorites), for: .touchDown)
        button4.frame = CGRect(x: 0, y: 0, width: 34, height: 33)
        let barButton4 = UIBarButtonItem(customView: button4)
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let navigationBarButtonItemsArray = [barButton4, spacer, barButton3,spacer,barButton2,spacer,barButton]
        
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToFavorites(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "favorites") as? FavoritesViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToProfile(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileViewController
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

