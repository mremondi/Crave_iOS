//
//  nearbyRestaurants.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

public class NearbyRestaurants{
    var nearbyRestaurants: [Restaurant]
    
    init(){
        nearbyRestaurants = []
    }
    
    func add(restaurant: Restaurant){
        nearbyRestaurants.append(restaurant)
    }
    
    func getNearbyRestaurants()->[Restaurant]{
        return nearbyRestaurants
    }
    
    func clear(){
        nearbyRestaurants = []
    }
    
    func getRestaurant(id: String)->Restaurant?{
        for thing in nearbyRestaurants{
            if (thing.getId() == id){
                return thing
            }
        }
        
        return nil
    }
}
