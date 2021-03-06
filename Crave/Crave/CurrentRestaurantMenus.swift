//
//  nearbyRestaurants.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// Current restaurant menus object class

public class CurrentRestaurantMenus{
    var currentRestaurantMenus: [Menu]
    
    init(){
        currentRestaurantMenus = []
    }
    
    func add(menu: Menu){
        currentRestaurantMenus.append(menu)
    }
    
    func getCurrentRestaurantMenus()->[Menu]{
        return currentRestaurantMenus
    }
    
    func clear(){
        currentRestaurantMenus = []
    }
    
    func getMenu(id: String)->Menu?{
        for thing in currentRestaurantMenus{
            if (thing.getID() == id){
                return thing
            }
        }
        
        return nil
    }
    
    func getMenu(name: String)->Menu?{
        for thing in currentRestaurantMenus{
            if (thing.getName() == name){
                return thing
            }
        }
        
        return nil
    }
}
