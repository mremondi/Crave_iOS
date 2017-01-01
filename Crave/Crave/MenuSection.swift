//
//  MenuSection.swift
//  Crave
//
//  Created by Robert Durst on 12/31/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import Foundation

public class MenuSection{
    //Fields
    var sectionName: String
    var sectionItems = [MenuItem]()
    
    init(sectionName: String, sectionItems: [MenuItem]) {
        self.sectionName = sectionName
        self.sectionItems = sectionItems
    }
    
    func getItems()->[MenuItem]{
        return self.sectionItems
    }
    
    func getSectionName()->String{
        return self.sectionName
    }
    
    func addItem(item: MenuItem){
        self.sectionItems.append(item)
    }
    
    func getItem(id: String)->MenuItem{
        for item in sectionItems{
            if (item.id == id){
                return item
            }
        }
        
        return sectionItems[0]
    }
}
