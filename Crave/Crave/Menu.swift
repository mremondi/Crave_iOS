//
//  Menu.swift
//  Crave
//
//  Created by Robert Durst on 11/27/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import Foundation


public class Menu{
    //Fields
    var menuName: String
    var restaurantID: String
    var sections: [String]
    var items: [String]
    var create_date: String
    var id: String
    
    init(id: String, menuName: String, restaurantID: String, sections: [String], items: [String], create_date: String) {
        self.id = id
        self.menuName = menuName
        self.restaurantID = restaurantID
        self.sections = sections
        self.items = items
        self.create_date = create_date
    }
    
    func getID()->String{
        return id
    }
    
    func getName()->String{
        return menuName
    }
    
    func getSections()->[String]{
        return sections
    }
    
    func getItems()->[String]{
        return items
    }
}
