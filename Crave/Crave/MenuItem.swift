//
//  MenuItem.swift
//  Crave
//
//  Created by Robert Durst on 12/31/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// Menu item object class.

import Foundation

public class MenuItem{
    
    var id = String()
    var menuID = String()
    var restaurantID = String()
    var name = String()
    var numberOfRatings = String()
    var rating = String()
    var description = String()
    var menuSection = "etc"
    var price = String()
    var restaurantName = String()
    
    init(id: String, menuID: String, restaurantID: String, name: String, numberOfRatings: String, rating: String, description: String, menuSection: String, price: String, restaurantName: String){
    
        self.id = id
        self.menuID = menuID
        self.restaurantID = restaurantID
        self.name = name
        self.numberOfRatings = numberOfRatings
        self.rating = rating
        self.description = description
        self.price = price
        self.restaurantName = restaurantName
        
        if (menuSection != ""){
            self.menuSection = menuSection
        }
        
    }
}
