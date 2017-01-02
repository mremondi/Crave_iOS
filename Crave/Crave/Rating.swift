//
//  Rating.swift
//  Crave
//
//  Created by Robert Durst on 1/1/17.
//  Copyright © 2017 Crave. All rights reserved.
//
// Rating object class.

import Foundation

public class Rating{
    //Fields
    var itemID = String()
    var id = String()
    var rating = String()
    
    init(itemID: String, id: String, rating: String) {
        self.itemID = itemID
        self.id = id
        self.rating = rating
    }
    
}
