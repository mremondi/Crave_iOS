//
//  Restaurant.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

public class Restaurant{
    
    var name: String
    var address: String
    var loc: [Double]
    var zipcode: String
    var tags: [String]
    var menus: [String]
    var url: String
    var createDate: String
    
    init(name:String, address: String, loc: [Double], zipcode: String, tags: [String], menus: [String],
         url: String, createDate: String){
        
        self.name = name
        self.address = address
        self.loc = loc
        self.zipcode = zipcode
        self.tags = tags
        self.menus = menus
        self.url = url
        self.createDate = createDate
    }
    
    func getName()->String{
        return self.name
    }
    
    func getAddress()->String{
        return self.address
    }
    
    func getLoc()->[Double]{
        return self.loc
    }
    
    func getLat()->Double{
        return loc[0]
    }
    
    func getLon()->Double{
        return loc[1]
    }
    
    func getTags()->[String]{
        return self.tags
    }
    
    func getMenus()->[String]{
        return self.menus
    }
    
    func getUrl()->String{
        return self.url
    }
    
    func getCreateDate()->String{
        return self.createDate
    }
}
