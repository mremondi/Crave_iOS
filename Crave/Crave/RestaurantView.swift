//
//  RestaurantView.swift
//  Crave
//
//  Created by Robert Durst on 11/25/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class RestaurantView: UIView {
    
    var restaurantLogoImage = UIImageView()
    let view = UIView()

    func create(id: String)->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        let restaurant = nearbyRestaurants.getRestaurant(id: id)!
        
        //The Restaurant Logo
        restaurantLogoImage.downloadedFrom(link: restaurant.getPhotoURL())
        restaurantLogoImage.frame = CGRect(x: 10, y: 65, width: width-20, height: 150)
        
        view.addSubview(restaurantLogoImage)
        
        
        
        
        return view
    }

}
