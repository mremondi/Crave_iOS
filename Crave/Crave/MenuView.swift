//
//  MenuView.swift
//  Crave
//
//  Created by Robert Durst on 12/31/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    //Initializes the element fields of the view
    let view = UIScrollView()
    
    weak var delegate: MenuTransitionDelegate?

    //This data is overridden and not actually used
    var sections = ["Section 1", "Section 2", "Section 3", "Section 4", "Section 5"]
    
    func create(sections: [MenuSection])->UIScrollView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        //let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.black
        
        var counter = 0
        
        //Set up the sections
        for i in 0...sections.count-1{
            let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0+(counter*35), width: Int(width), height: 30))
            sectionLabel.text = sections[i].getSectionName()
            sectionLabel.textColor = UIColor.white
            sectionLabel.textAlignment = .center
            sectionLabel.font = UIFont(name: "Helvetica", size: 30)
            
            counter += 1
            
            for item in (sections[i].getItems()){
                let itemButton = UIButton(frame: CGRect(x: 0, y: 0+(counter*35), width: Int(width), height: 30))
                
                //The menu item name
                let buttonLabel = UILabel(frame: CGRect(x: 5, y: 0, width: width, height: 30))
                buttonLabel.text = item.name
                buttonLabel.textColor = UIColor.black
                buttonLabel.font = UIFont(name: "Helvetica", size: 12)
                itemButton.addSubview(buttonLabel)
                
                //The menu item rating and item price
                let ratingPriceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width-5, height: 30))
                
                var rating = (Double(item.rating)!)
                
                if (item.rating != "0"){
                    rating = (Double(item.rating)!/Double(item.numberOfRatings)!)
                    if (rating > 5.0){
                        rating = rating/2
                    }
                }
                
                
                
                if ((item.rating != "0")&&(item.rating != "null")){
                    ratingPriceLabel.text = "Price: $" + String(format: "%.2f", Double(item.price)!) + " Rating: " + String(format: "%.2f", rating)
                }
                else if ((item.price != "0")&&(item.price != "null")){
                    ratingPriceLabel.text = "Price: $" + String(format: "%.2f", Double(item.price)!)
                }
                
                ratingPriceLabel.textColor = UIColor.black
                ratingPriceLabel.font = UIFont(name: "Helvetica", size: 12)
                ratingPriceLabel.textAlignment = .right
                itemButton.addSubview(ratingPriceLabel)

                itemButton.setTitle(item.id+"/"+item.menuSection, for: .normal)
                itemButton.setTitleColor(UIColor.white, for: .normal)
                itemButton.titleLabel!.font =  UIFont(name: "Helvetica", size: 1)
                itemButton.backgroundColor = UIColor.white
                itemButton.layer.cornerRadius = 5
                itemButton.layer.borderWidth = 1
                itemButton.layer.borderColor = UIColor.black.cgColor
                itemButton.layer.shadowColor = UIColor.black.cgColor
                itemButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                itemButton.layer.masksToBounds = false
                itemButton.layer.shadowRadius = 1.0
                itemButton.layer.shadowOpacity = 0.5
                
                itemButton.addTarget(self, action: #selector(MenuView.itemButtonSelected), for: .touchDown)
                
                view.addSubview(itemButton)
                
                counter += 1
            }
            
        
            view.addSubview(sectionLabel)
        }
        
        return view
    }
    
    func itemButtonSelected(sender: UIButton){
        
        var itemID = ""
        var section = ""
        var typeSwitchVar = false
        for char in ((sender.titleLabel?.text)?.characters)!{
            if(char == "/"){
                typeSwitchVar = true
                
            }
            else if(typeSwitchVar){
                section.append(char)
            }
            else{
                itemID.append(char)
            }
        }

        delegate?.TransitionToItem(menuItemID: itemID, menuItemSection: section)
    }
    
    
    
}


