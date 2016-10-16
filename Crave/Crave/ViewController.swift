//
//  ViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/15/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.drawMap), name:NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
        
        self.navigationItem.title = "Near Me"
         self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        self.tabBarItem.title = ""
        self.navigationController?.navigationBar.topItem?.title = "Near Me"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func drawMap(){
        let map = mapView.create()
        self.view = mapView.getView()
        mapView.UpdateMap(restaurants: nearbyRestaurants, mapView: map)
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

