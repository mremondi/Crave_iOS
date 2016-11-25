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
    
    func requestNearbyRestaurants(nearbyRestaurants: NearbyRestaurants){
        
        nearbyRestaurants.clear()
        
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
                    let id = thing.1["_id"]
                    let photoURL = thing.1["restaurant_logo_URL"]
                    
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
                    let restaurantToAdd = Restaurant(id: String(describing: id), name: String(describing: name), address: String(describing: address), loc: loc, zipcode: String(describing: zipcode), tags: tags, menus: menus, url: String(describing: url), createDate: String(describing: createDate), photoURL: String(describing: photoURL))
                    
                    nearbyRestaurants.add(restaurant: restaurantToAdd)
                }
                
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
            }
        }
    }
    
    func requestLogin(email: String, password: String){
        
        url = ca.API_ENDPOINT + ca.LOGIN_ENPOINT
        
        data = ["email" : email, "password" : password]
        
        headers = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        //Sending the request
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginIdentifier"), object: nil, userInfo: ["Result" : "Fail"])
                    return
                }
                
                if let value = response.result.value {
                    let todo = JSON(value)
                    
                    
                    let id = todo["_id"] //string
                    let email = todo["email"] //string
                    let ratings = todo["ratings"] //array
                    let profileJson = todo["profile"] //dictionary
                    let gender = profileJson["gender"] //string
                    let restaurants = profileJson["restaurants"] //array
                    let picture = profileJson["picture"] //unknown
                    let website = profileJson["website"] //string
                    let name = profileJson["name"] //name
                    let location = profileJson["location"] //string
                    
                    

                    profile = Profile(id: String(describing: id), email: String(describing: email), gender: String(describing: gender), website: String(describing: website), name: String(describing: name), location: String(describing: location))
                    
                    print(todo)
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginIdentifier"), object: nil, userInfo: ["Result" : "Success"])
                }
        }

    }
    
    func requestUpdate(email: String, name: String, id: String){
        
        url = ca.API_ENDPOINT + ca.UPDATE_USER_ENDPOINT
        
        data = ["email" : email, "name" : name, "id" : id]
        
        headers = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        //Sending the request
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let todo = JSON(value)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileIdentifier"), object: nil)
                }
        }
        
    }
    
    func requestChangePassword(password: String, id: String){
        
        url = ca.API_ENDPOINT + ca.UPDATE_PASSWORD
        
        data = ["password" : password, "id" : id]
        
        headers = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        //Sending the request
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let todo = JSON(value)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileIdentifier"), object: nil)
                }
        }
        
    }
    
    func requestLogout(){
        
        url = ca.API_ENDPOINT + ca.LOGOUT_ENDPOINT
        
        //Sending the request
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let todo = JSON(value)
                }
        }
        
    }

}
