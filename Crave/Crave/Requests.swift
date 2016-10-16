//
//  Requests.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class Requests{

    var url = ""
    var data: [String:Any] = [:]
    var headers: [String:Any] = [:]
    
    let ca = CraveApi()
    
    func callRequest(nearbyRestaurants: NearbyRestaurants){
        
        url = ca.API_ENDPOINT + ca.RESTAURANTS_ENPOINT
        url = url + "/" + String(locationManagerClass.getLocationLatitude()) + "/" + String(locationManagerClass.getLocationLongitude())
        
        Alamofire.request(url).responseJSON { response in
            debugPrint(response)
            
            if let value = response.result.value {
                let todo = JSON(value)
                
                for thing in todo{
                   
                    
                    let name = thing.1["restaurant"]
                    let address = thing.1["address"]
                    let createDate = thing.1["create_date"]
                    let locations = thing.1["loc"]["coordinates"]
                    let menuList = thing.1["menus"]
                    let url = thing.1["restaurant_url"]
                    let tagList = thing.1["tags"]
                    let zipcode = thing.1["zipcode"]
                    
                    var loc:[Double] = []
                    for thing in locations{
                        loc.append(Double(String(describing: thing.1))!)
                    }
                    let temp = loc[1]
                    loc[1] = loc[0]
                    loc[0] = temp
                    
                    var menus: [String] = []
                    for thing in menuList{
                        menus.append(String(describing: thing.1))
                    }
                    
                    var tags: [String] = []
                    for thing in tagList{
                        tags.append(String(describing: thing.1))
                    }
                    let restaurantToAdd = Restaurant(name: String(describing: name), address: String(describing: address), loc: loc, zipcode: String(describing: zipcode), tags: tags, menus: menus, url: String(describing: url), createDate: String(describing: createDate))
                    
                    nearbyRestaurants.add(restaurant: restaurantToAdd)
                }
                
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
            }
        }
    }
    
}
