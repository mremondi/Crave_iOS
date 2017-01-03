//
//  ItemView.swift
//  Crave
//
//  Created by Robert Durst on 12/31/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import Cosmos

class ItemView: UIView {
    
    let view = UIView()
    let restaurantTitle = UILabel()
    let menuItemPictureView = UIImageView()
    var menuItemPicture = UIImage()
    let itemLabel = UILabel()
    let itemName = UILabel()
    let itemPrice = UILabel()
    let itemDescriptionTitle = UILabel()
    let itemDescriptionText = UITextView()
    let dietaryInformationTitle = UILabel()
    let dietaryInformationText = UITextView()
    let cosmosView = Cosmos.CosmosView()
    let rateButton = UIButton()
    weak var delegate: ItemTransitionDelegate?
    
    func create(item: MenuItem)->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        //let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Restaurant Title
        restaurantTitle.frame = CGRect(x: 10, y: 60, width: width-20, height: 60)
        restaurantTitle.text = item.restaurantName
        restaurantTitle.font = UIFont(name: "Helvetica", size: 30)
        restaurantTitle.adjustsFontSizeToFitWidth = true
        restaurantTitle.textColor = UIColor.black
        restaurantTitle.textAlignment = .center
        view.addSubview(restaurantTitle)
        
        //Item Picture
        //Set the picture
        menuItemPicture = UIImage(named: "launchImage")!
        //Set up the image view
        menuItemPictureView.frame = CGRect(x: 60, y: 110, width: width-120, height: 200)
        menuItemPictureView.image = menuItemPicture
        view.addSubview(menuItemPictureView)
        
        //Item Label with the item name and the item price
        //Set the frame of the item label
        itemLabel.frame = CGRect(x: 5, y: 320, width: width-10, height: 40)
        //Set up the item name
        itemName.frame = CGRect(x: 0, y: 0, width: width-0, height: 40)
        itemName.text = item.name
        itemName.font = UIFont(name: "Helvetica", size: 18)
        itemName.textColor = UIColor.darkGray
        itemName.textAlignment = .left
        //Set up the item price
        itemPrice.frame = CGRect(x: 0, y: 0, width: width-10, height: 40)
        itemPrice.text = "$" + String(format: "%.2f", Double(item.price)!)
        itemName.font = UIFont(name: "Helvetica", size: 15)
        itemPrice.textColor = UIColor.darkGray
        itemPrice.textAlignment = .right
        
        itemLabel.addSubview(itemName)
        itemLabel.addSubview(itemPrice)
        
        view.addSubview(itemLabel)
        
        //Horizontal Line
        let horLine1 = UIImageView(frame: CGRect(x: 5, y: 350, width: width-10, height: 1))
        horLine1.backgroundColor = UIColor.lightGray
        view.addSubview(horLine1)
        
        //Item Description
        //First put the label of the title
        itemDescriptionTitle.frame = CGRect(x: 5, y: 350, width: width, height: 25)
        itemDescriptionTitle.text = "Description:"
        itemDescriptionTitle.textAlignment = .left
        itemDescriptionTitle.textColor = UIColor.black
        itemDescriptionTitle.font = UIFont(name: "Helvetica", size: 15)
        view.addSubview(itemDescriptionTitle)
        
        //Then put the actual description
        itemDescriptionText.frame = CGRect(x: 5, y: 370, width: width, height: 100)
        itemDescriptionText.text = item.description
        itemDescriptionText.textAlignment = .left
        itemDescriptionText.textColor = UIColor.darkGray
        itemDescriptionText.font = UIFont(name: "Helvetica", size: 15)
        itemDescriptionText.isUserInteractionEnabled = false
        view.addSubview(itemDescriptionText)
        
        //Horizontal Line
        let horLine2 = UIImageView(frame: CGRect(x: 5, y: 470, width: width-10, height: 1))
        horLine2.backgroundColor = UIColor.lightGray
        view.addSubview(horLine2)
        
        //Item Dietary information
        
        //Item Rating with the star visual
        cosmosView.frame = CGRect(x: 0, y: 475, width: width, height: 50)
        
        if ((item.rating != "0")&&(item.rating != "null")){
            cosmosView.rating = (Double(item.rating)!/Double(item.numberOfRatings)!)
            if (cosmosView.rating > 5.0){
                cosmosView.rating = cosmosView.rating/2
            }
        }
        else{
            cosmosView.rating = 0.0
        }
        
        cosmosView.settings.updateOnTouch = false
        // Show only fully filled stars
        //cosmosView.settings.fillMode = .full
        // Other fill modes: .half, .precise
        // Change the size of the stars
        cosmosView.settings.starSize = 40
        // Set the distance between stars
        cosmosView.settings.starMargin = 5
        // Set the color of a filled star
        cosmosView.settings.filledColor = UIColor.red
        // Set the border color of an empty star
        cosmosView.settings.emptyBorderColor = UIColor.red
        // Set the border color of a filled star
        cosmosView.settings.filledBorderColor = UIColor.red
        view.addSubview(cosmosView)
        
        //Create the rate button
        rateButton.frame = CGRect(x: width-100, y: 475, width: 100, height: 45)
        rateButton.setTitle("Rate", for: .normal)
        rateButton.setTitleColor(UIColor.white, for: .normal)
        //rateButton.titleLabel?.font = UIFont(name: "Hel", size: <#T##CGFloat#>)
        rateButton.backgroundColor = UIColor.red
        rateButton.layer.cornerRadius = 5
        rateButton.layer.borderWidth = 1
        rateButton.layer.borderColor = UIColor.black.cgColor
        rateButton.layer.shadowColor = UIColor.black.cgColor
        rateButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        rateButton.layer.masksToBounds = false
        rateButton.layer.shadowRadius = 1.0
        rateButton.layer.shadowOpacity = 0.5
        rateButton.addTarget(self, action: #selector(ItemView.rateButtonSelected), for: .touchDown)
        view.addSubview(rateButton)
        
        return view
    }
    
    //What happens when the rate button is selected, it sends a call to the viewControllerClass so that the view controller can call the popup
    func rateButtonSelected(){
        delegate?.TransitionToPopup()
    }
    
    

}
