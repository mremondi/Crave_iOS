//
//  Requests.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// All the API calls. I use Alamofire for the call and SwiftJSON to decode the JSON. The function/purpose of the call is fairly obvious from the function name. Note that most of the calls create object from the data. This app has a strong OOP focus. Also notice that this has a pretty hard coded solution to the mystery "?" that results from unrecognized characters. This will lilely be changed later as it is not a very scalable solution.

import UIKit
import Alamofire
import SwiftyJSON

public class Requests{

    var url = ""
    var data: [String:Any] = [:]
    var headers: [String:Any] = [:]
    
    let ca = CraveApi()
	
	func requestRestaurantByID(id: String, vc: RestaurantController) {
				
		var resultRestaurant: Restaurant?
		
		url = ca.API_ENDPOINT + ca.RESTAURANTS_ENPOINT
		url = url + "/" + id
		Alamofire.request(url).responseJSON { response in
			if let value = response.result.value {
				let restaurant = JSON(value)
					
				
				let name = restaurant["restaurant"]
				let address = restaurant["address"]
				let createDate = restaurant["create_date"]
				let locations = restaurant["loc"]["coordinates"]
				let menuList = restaurant["menus"]
				let url = restaurant["restaurant_URL"]
				let tagList = restaurant["tags"]
				let zipcode = restaurant["zipcode"]
				let id = restaurant["_id"]
				let photoURL = restaurant["restaurant_logo_URL"]
				let phoneNumber = restaurant["phone_number"]
				
				var loc:[Double] = []
				for location in locations{
					loc.append(Double(String(describing: location.1))!)
				}
				let temp = loc[1]
				loc[1] = loc[0]
				loc[0] = temp
				
				var menus: [String] = []
				for menu in menuList{
					menus.append(String(describing: menu.1))
				}
				
				var tags: [String] = []
				for tag in tagList{
					tags.append(String(describing: tag.1))
				}
				resultRestaurant = Restaurant(id: String(describing: id), name: String(describing: name), address: String(describing: address), loc: loc, zipcode: String(describing: zipcode), tags: tags, menus: menus, url: String(describing: url), createDate: String(describing: createDate), photoURL: String(describing: photoURL), phoneNumber: String(describing: phoneNumber))
				
				vc.restaurant = resultRestaurant
				vc.ivRestaurantLogo!.downloadedFrom(link: (resultRestaurant?.getPhotoURL())!)
				menus = (resultRestaurant?.getMenus())!
				self.requestMenusByID(menuIDs: menus, vc: vc)
			}
		}
	}
    
    func requestNearbyRestaurants(nearbyRestaurants: NearbyRestaurants){
        
        nearbyRestaurants.clear()
        
        url = ca.API_ENDPOINT + ca.RESTAURANTS_ENPOINT
        url = url + "/" + String(locationManagerClass.getLocationLatitude()) + "/" + String(locationManagerClass.getLocationLongitude())
        
        Alamofire.request(url).responseJSON { response in
            //debugPrint(response)
            
            if let value = response.result.value {
                let todo = JSON(value)
                
                for thing in todo{
                   
                    
                    let name = thing.1["restaurant"]
                    let address = thing.1["address"]
                    let createDate = thing.1["create_date"]
                    let locations = thing.1["loc"]["coordinates"]
                    let menuList = thing.1["menus"]
                    let url = thing.1["restaurant_URL"]
                    let tagList = thing.1["tags"]
                    let zipcode = thing.1["zipcode"]
                    let id = thing.1["_id"]
                    let photoURL = thing.1["restaurant_logo_URL"]
                    let phoneNumber = thing.1["phone_number"]
                    
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
                    let restaurantToAdd = Restaurant(id: String(describing: id), name: String(describing: name), address: String(describing: address), loc: loc, zipcode: String(describing: zipcode), tags: tags, menus: menus, url: String(describing: url), createDate: String(describing: createDate), photoURL: String(describing: photoURL), phoneNumber: String(describing: phoneNumber))
                    
                    nearbyRestaurants.add(restaurant: restaurantToAdd)
                }
                
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
            }
        }
    }
    
	func requestMenusByID(menuIDs: [String], vc: RestaurantController) {
		for menuID in menuIDs{
			url = ca.API_ENDPOINT + ca.MENUS_ENDPOINT
			url = url + "/" + menuID
			Alamofire.request(url).responseJSON { response in
				guard response.result.error == nil else {
					// got an error in getting the data, need to handle it
					print("error calling POST on /todos/1")
					print(response.result.error!)
					return
				}
				
				if let value = response.result.value {
					let todo = JSON(value)
					
					let id = String(describing: todo["_id"])
					let menuName = String(describing: todo["menuName"])
					let restaurantID = String(describing: todo["restaurantId"])
					let sections = todo["sections"]
					let items = todo["items"]
					let create_date = String(describing: todo["create_date"])
					
					var sectionList = [MenuSection]()
					var itemList = [String]()
					
					for section in sections{
						var sectionText = String(describing: section.1)
						if (sectionText.contains("�")){
							if(sectionText.contains("Entr")){
								sectionText = sectionText.replace(target: "�", withString:"é")
							}
							else if((sectionText.contains("Entrees"))){
								sectionText = sectionText.replace(target: "Entrees", withString:"Entrées")
							}
							
							
							
						}
						else if(sectionText.contains("&")){
							sectionText = sectionText.replace(target: "&", withString:"and")
						}
						
						
						let menuSection = MenuSection(sectionName: String(describing: sectionText), sectionItems: [])
						sectionList.append(menuSection)
					}
					
					sectionList.append(MenuSection(sectionName: "etc", sectionItems: []))
					
					for item in items{
						itemList.append(String(describing: item))
					}
					
					let menu = Menu(id: id, menuName: menuName, restaurantID: restaurantID, sections: sectionList, items: itemList, create_date: create_date)
					
					
					//self.getSectionItems(sections: sectionList, menuID: id)
					vc.menus.append(menu)
					vc.menuTable.reloadData()
				}
			}
			
		}
	}
	
	func requestMenuItems(menuID: String, menuSection: MenuSection, vc: MenuController){
		
		url = ca.API_ENDPOINT + ca.MENU_ITEMS_ENDPONT
		url = url + menuID + "/" + menuSection.getSectionName()
		if url.contains(" "){
			url = url.replace(target: " ", withString: "%20")
		}
		Alamofire.request(url).responseJSON{ response in
			if let value = response.result.value {
				let items = JSON(value)
				for thing in items{
					let item = thing.1
					
					let menuID = String(describing: item["menuID"])
					let name = String(describing: item["name"])
					let numberOfRatings = String(describing: item["numberOfRatings"])
					let description = String(describing: item["description"])
					let restaurantID = String(describing: item["restaurant_id"])
					let rating = String(describing: item["rating"])
					let price = String(describing: item["price"])
					let section = String(describing: item["menuSection"])
					let id = String(describing: item["_id"])
					let restaurantName = String(describing: item["restaurant_name"])

					let menuItem = MenuItem(id: id, menuID: menuID, restaurantID: restaurantID, name: name, numberOfRatings: numberOfRatings, rating: rating, description: description, menuSection: section, price: price, restaurantName: restaurantName)
						
					menuSection.addItem(item: menuItem)
					vc.menuItemTable.reloadData()
				}
			}
		}
	}
	
	
//    func requestMenu(menuIDs: [String], vc: RestaurantController){
//        
//        for menuID in menuIDs{
//            url = ca.API_ENDPOINT + ca.MENUS_ENDPOINT
//            url = url + "/" + menuID
//            Alamofire.request(url).responseJSON { response in
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling POST on /todos/1")
//                    print(response.result.error!)
//                    return
//                }
//                
//                if let value = response.result.value {
//                    let todo = JSON(value)
//                    
//                    let id = String(describing: todo["_id"])
//                    let menuName = String(describing: todo["menuName"])
//                    let restaurantID = String(describing: todo["restaurantId"])
//                    let sections = todo["sections"]
//                    let items = todo["items"]
//                    let create_date = String(describing: todo["create_date"])
//
//                    var sectionList = [MenuSection]()
//                    var itemList = [String]()
//                    
//                    for section in sections{
//                        var sectionText = String(describing: section.1)
//                        if (sectionText.contains("�")){
//                            if(sectionText.contains("Entr")){
//                                sectionText = sectionText.replace(target: "�", withString:"é")
//                            }
//                            else if((sectionText.contains("Entrees"))){
//                                sectionText = sectionText.replace(target: "Entrees", withString:"Entrées")
//                            }
//                            
//
//                            
//                        }
//                        else if(sectionText.contains("&")){
//                            sectionText = sectionText.replace(target: "&", withString:"and")
//                        }
//
//                        
//                        let menuSection = MenuSection(sectionName: String(describing: sectionText), sectionItems: [])
//                        sectionList.append(menuSection)
//                    }
//                    
//                    sectionList.append(MenuSection(sectionName: "etc", sectionItems: []))
//                    
//                    for item in items{
//                        itemList.append(String(describing: item))
//                    }
//                    
//                    let menu = Menu(id: id, menuName: menuName, restaurantID: restaurantID, sections: sectionList, items: itemList, create_date: create_date)
//                    
//                    currentRestaurantMenus.add(menu: menu)
//                    
//                    self.getSectionItems(sections: sectionList, menuID: id)
//                    
//                    
//                    if (currentRestaurantMenus.getCurrentRestaurantMenus().count == menuIDs.count){
//                        vc.updateMenuButtonTitles()
//                    }
//                }
//            }
// 
//        }
//        
//    }
    
    func getSectionItems(sections: [MenuSection], menuID: String){
        
        var listOfItems = [MenuItem]()
        var listOfSectionNames = [String]()
        
        for section in sections{
            
            listOfSectionNames.append(section.sectionName)
        }
        
        url = ca.API_ENDPOINT + ca.MENU_ITEMS_ENDPONT+menuID
        Alamofire.request(url).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling POST on /todos/1")
                print(response.result.error!)
                return
            }
            
            if let value = response.result.value {
                let todo = JSON(value)
                for thing in todo{
                    let item = thing.1
                    
                    
                    let menuID = String(describing: item["menuID"])
                    var name = String(describing: item["name"])
                    if (name.contains("�")){
                        if (name.contains("with�")){
                            name = name.replace(target: "�", withString:" ...")
                        }
                        else if((name.contains("saut�"))||(name.contains("b�arnaise"))){
                            name = name.replace(target: "�", withString:"é")
                        }
                        else if((name.contains("�s"))||(name.contains("we�ll"))){
                            name = name.replace(target: "�", withString:"\'")
                        }
                        else{
                            name = name.replace(target: "�", withString:"")
                        }
                        
                    }
                    let numberOfRatings = String(describing: item["numberOfRatings"])
                    //let dietaryInfo = String(describing: item["diestaryInfo"])
                    var description = String(describing: item["description"])
                    if (description.contains("�")){
                        if((description.contains("saut�"))||(description.contains("b�arnaise"))||(description.contains("Cr�me"))){
                            description = description.replace(target: "�", withString:"é")
                        }
                        else if((description.contains("�s"))||(description.contains("we�ll"))){
                            description = description.replace(target: "�", withString:"\'")
                        }
                        else{
                            description = description.replace(target: "�", withString:"")
                        }
                        
                    }
                    let restaurantID = String(describing: item["restaurant_id"])
                    let rating = String(describing: item["rating"])
                    //let tags = String(item["tags"])
                    let price = String(describing: item["price"])
                    var menuSection = String(describing: item["menuSection"])
                    if (menuSection.contains("�")){
                        if(menuSection.contains("Entr")){
                            menuSection = menuSection.replace(target: "�", withString:"é")
                        }
                    }
                    if(menuSection.contains("&")){
                        menuSection = menuSection.replace(target: "&", withString:"and")
                    }
                    let id = String(describing: item["_id"])
                    //let createDate = String(item["create_date"])
                    //let menuSubSection = String(item["menuSubSection"])
                    var restaurantName = String(describing: item["restaurant_name"])
                    if (restaurantName.contains("�")){
                        if((restaurantName.contains("Entr�"))||(restaurantName.contains("Caf�"))){
                            restaurantName = restaurantName.replace(target: "�", withString:"é")
                        }
                        else if (restaurantName.contains("�s")){
                            restaurantName = restaurantName.replace(target: "�", withString:"\'")
                        }
                        else{
                            restaurantName = restaurantName.replace(target: "�", withString:"")
                        }
                        
                    }
                    
                    let menuItem = MenuItem(id: id, menuID: menuID, restaurantID: restaurantID, name: name, numberOfRatings: numberOfRatings, rating: rating, description: description, menuSection: menuSection, price: price, restaurantName: restaurantName)
                    
                    listOfItems.append(menuItem)
                }
                
                for item in listOfItems{
                    print(item.menuSection)
                    print(listOfSectionNames)
                    sections[(listOfSectionNames.index(of: item.menuSection))!].addItem(item: item)
                }
                
                //for section in sections{
                    //print(section.getItems().count)
                //}
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
                    //let ratings = todo["ratings"] //array
                    let profileJson = todo["profile"] //dictionary
                    let gender = profileJson["gender"] //string
                    //let restaurants = profileJson["restaurants"] //array
                    //let picture = profileJson["picture"] //unknown
                    let website = profileJson["website"] //string
                    let name = profileJson["name"] //name
                    let location = profileJson["location"] //string
                    
                    
                    profile = Profile(id: String(describing: id), email: String(describing: email), gender: String(describing: gender), website: String(describing: website), name: String(describing: name), location: String(describing: location))
                    
                    //print(todo)
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginIdentifier"), object: nil, userInfo: ["Result" : "Success"])
                }
        }

    }
	
	func requestRegister(email: String, password: String){
		
		url = ca.API_ENDPOINT + ca.REGISTER_ENDPOINT
		
		data = ["email" : email, "password" : password]
		
		headers = ["Content-Type" : "application/x-www-form-urlencoded"]
		
		//Sending the request
		Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
			.responseJSON { response in
				guard response.result.error == nil else {
					// got an error in getting the data, need to handle it
					print("error calling POST on /todos/1")
					print(response.result.error!)
					NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterIdentifier"), object: nil, userInfo: ["Result" : "Fail"])
					return
				}
				
				if let value = response.result.value {
					let todo = JSON(value)
					
					
					let id = todo["_id"] //string
					let email = todo["email"] //string
					//let ratings = todo["ratings"] //array
					let profileJson = todo["profile"] //dictionary
					let gender = profileJson["gender"] //string
					//let restaurants = profileJson["restaurants"] //array
					//let picture = profileJson["picture"] //unknown
					let website = profileJson["website"] //string
					let name = profileJson["name"] //name
					let location = profileJson["location"] //string
					
					
					profile = Profile(id: String(describing: id), email: String(describing: email), gender: String(describing: gender), website: String(describing: website), name: String(describing: name), location: String(describing: location))
					
					//print(todo)
					NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterIdentifier"), object: nil, userInfo: ["Result" : "Success"])
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
                    //let todo = JSON(value)
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
                    //let todo = JSON(value)
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
                    //let todo = JSON(value)
                }
        }
        
    }
    
    func requestAllRestaurants(){
        url = ca.API_ENDPOINT + ca.RESTAURANTS_ENPOINT
        
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
                    print(todo)
                }
        }

    }
    
    func getAllItems(){
        url = ca.API_ENDPOINT + ca.ITEMS_ENDPOINT
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
                    
                    //Reset the global list of all items
                    curAllItemList = []
                    
                    let todo = JSON(value)
                    for thing in todo{
                        let item = thing.1
                        
                        
                        let menuID = String(describing: item["menuID"])
                        var name = String(describing: item["name"])
                        if (name.contains("�")){
                            if (name.contains("with�")){
                                name = name.replace(target: "�", withString:" ...")
                            }
                            else if((name.contains("saut�"))||(name.contains("b�arnaise"))){
                                name = name.replace(target: "�", withString:"é")
                            }
                            else if((name.contains("�s"))||(name.contains("we�ll"))){
                                name = name.replace(target: "�", withString:"\'")
                            }
                            else{
                                name = name.replace(target: "�", withString:"")
                            }
                            
                        }
                        let numberOfRatings = String(describing: item["numberOfRatings"])
                        //let dietaryInfo = String(describing: item["diestaryInfo"])
                        var description = String(describing: item["description"])
                        if (description.contains("�")){
                            if((description.contains("saut�"))||(description.contains("b�arnaise"))||(description.contains("Cr�me"))){
                                description = description.replace(target: "�", withString:"é")
                            }
                            else if((description.contains("�s"))||(description.contains("we�ll"))){
                                description = description.replace(target: "�", withString:"\'")
                            }
                            else{
                                description = description.replace(target: "�", withString:"")
                            }
                            
                        }
                        let restaurantID = String(describing: item["restaurant_id"])
                        let rating = String(describing: item["rating"])
                        //let tags = String(item["tags"])
                        let price = String(describing: item["price"])
                        var menuSection = String(describing: item["menuSection"])
                        if (menuSection.contains("�")){
                            if(menuSection.contains("Entr")){
                                menuSection = menuSection.replace(target: "�", withString:"é")
                            }
                        }
                        if(menuSection.contains("&")){
                            menuSection = menuSection.replace(target: "&", withString:"and")
                        }
                        let id = String(describing: item["_id"])
                        //let createDate = String(item["create_date"])
                        //let menuSubSection = String(item["menuSubSection"])
                        var restaurantName = String(describing: item["restaurant_name"])
                        if (restaurantName.contains("�")){
                            if((restaurantName.contains("Entr�"))||(restaurantName.contains("Caf�"))){
                                restaurantName = restaurantName.replace(target: "�", withString:"é")
                            }
                            else if (restaurantName.contains("�s")){
                                restaurantName = restaurantName.replace(target: "�", withString:"\'")
                            }
                            else{
                                restaurantName = restaurantName.replace(target: "�", withString:"")
                            }
                            
                        }
                        
                        let menuItem = MenuItem(id: id, menuID: menuID, restaurantID: restaurantID, name: name, numberOfRatings: numberOfRatings, rating: rating, description: description, menuSection: menuSection, price: price, restaurantName: restaurantName)
                        
                        curAllItemList.append(menuItem)
                    }
                }
        }
        
    }
    
    
    func requestUserRatings(id:String, vc: CravingsViewController){
        url = ca.API_ENDPOINT + ca.GET_RATINGS_ENDPOINT+id
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
                    
                    var ratingsList: [Rating] = []
                    
                    for thing in todo{
                        let itemID = thing.1["itemID"]
                        let ratingID = thing.1["_id"]
                        let rating = thing.1["rating"]
                        
                        let ratingObj = Rating(itemID: String(describing: itemID), id: String(id), rating: String(describing: rating))
                        
                        ratingsList.append(ratingObj)
                    }
                    
                    if (ratingsList.count == todo.count){
                        self.getItemForCravings(vc: vc, ratingList: ratingsList)
                    }
                }
        }

    }
    
    func getItemForCravings(vc: CravingsViewController, ratingList: [Rating]){
        
        var itemList: [MenuItem] = []
        
        for rating in ratingList{
            url = ca.API_ENDPOINT + ca.ITEMS_ENDPOINT + "/" + rating.itemID
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
                        
                        print(todo)
                        
                        let item = todo
                        
                        let menuID = String(describing: item["menuID"])
                        var name = String(describing: item["name"])
                        if (name.contains("�")){
                            if (name.contains("with�")){
                                name = name.replace(target: "�", withString:" ...")
                            }
                            else if((name.contains("saut�"))||(name.contains("b�arnaise"))){
                                name = name.replace(target: "�", withString:"é")
                            }
                            else if((name.contains("�s"))||(name.contains("we�ll"))){
                                name = name.replace(target: "�", withString:"\'")
                            }
                            else{
                                name = name.replace(target: "�", withString:"")
                            }
                            
                        }
                        let numberOfRatings = String(describing: item["numberOfRatings"])
                        //let dietaryInfo = String(describing: item["diestaryInfo"])
                        var description = String(describing: item["description"])
                        if (description.contains("�")){
                            if((description.contains("saut�"))||(description.contains("b�arnaise"))||(description.contains("Cr�me"))){
                                description = description.replace(target: "�", withString:"é")
                            }
                            else if((description.contains("�s"))||(description.contains("we�ll"))){
                                description = description.replace(target: "�", withString:"\'")
                            }
                            else{
                                description = description.replace(target: "�", withString:"")
                            }
                            
                        }
                        let restaurantID = String(describing: item["restaurant_id"])
                        let ratingTotal = String(describing: item["rating"])
                        //let tags = String(item["tags"])
                        let price = String(describing: item["price"])
                        var menuSection = String(describing: item["menuSection"])
                        if (menuSection.contains("�")){
                            if(menuSection.contains("Entr")){
                                menuSection = menuSection.replace(target: "�", withString:"é")
                            }
                        }
                        if(menuSection.contains("&")){
                            menuSection = menuSection.replace(target: "&", withString:"and")
                        }

                        let id = String(describing: item["_id"])
                        //let createDate = String(item["create_date"])
                        //let menuSubSection = String(item["menuSubSection"])
                        var restaurantName = String(describing: item["restaurant_name"])
                        if (restaurantName.contains("�")){
                            if((restaurantName.contains("Entr�"))||(restaurantName.contains("Caf�"))){
                                restaurantName = restaurantName.replace(target: "�", withString:"é")
                            }
                            else if (restaurantName.contains("�s")){
                                restaurantName = restaurantName.replace(target: "�", withString:"\'")
                            }
                            else{
                                restaurantName = restaurantName.replace(target: "�", withString:"")
                            }
                            
                        }
                        
                        let menuItem = MenuItem(id: id, menuID: menuID, restaurantID: restaurantID, name: name, numberOfRatings: numberOfRatings, rating: ratingTotal, description: description, menuSection: menuSection, price: price, restaurantName: restaurantName)
                        
                        itemList.append(menuItem)
                        
                        if (ratingList.count == itemList.count){
                            vc.ratingData = ratingList
                            vc.data = itemList
                            vc.filteredData = vc.data
                            vc.tableView.reloadData()
                        }


                        
                    }
            }

        }
    }
    
    func sendUserRating(itemID: String, rating: String, userID: String){
        url = ca.API_ENDPOINT + ca.ITEMS_ENDPOINT + "/" + itemID + "/" + rating + "/" + userID
        //Sending the request
        Alamofire.request(url, method: .put)
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
