//
//  RestaurantView.swift
//  Crave
//
//  Created by Robert Durst on 11/25/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The view for the restaurants

import UIKit
import CoreLocation
import MapKit

class RestaurantView: UIView {
    
    //Initialize the element fields for this view
    var restaurantLogoImage = UIImageView()
    let view = UIScrollView()
    var menuLabel = UILabel()
    var cuisineTagsLabel = UILabel()
    var directionsButton = UIButton()
    var callButton = UIButton()
    var websiteButton = UIButton()
    var cuisineTags = UILabel()
    var phoneNumber = ""
    var latitude = ""
    var longitude = ""
    var locationName = ""
    var url = ""
    
    //Create the underlined format for the call button, direction button, and website button strings
    var attrs = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 20.0),
        NSForegroundColorAttributeName : UIColor.blue,
        NSUnderlineStyleAttributeName : 1] as [String : Any]
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")
    var attributedString3 = NSMutableAttributedString(string:"")

    //Create a list of buttons for the menus so that each button may be accessibleby referencing this array
    var menuButtonList = [UIButton]()
    
    //Create the delagate for communication between this view and its view controller
    weak var delegate: RestaurantTransitionDelegate?
    
    func create(id: String)->UIScrollView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        //let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        let restaurant = nearbyRestaurants.getRestaurant(id: id)!
        
        //The Restaurant Logo
        restaurantLogoImage.downloadedFrom(link: restaurant.getPhotoURL())
        restaurantLogoImage.frame = CGRect(x: 10, y: 0, width: width-20, height: 150)
        view.addSubview(restaurantLogoImage)
        
        //The menu label
        menuLabel.frame = CGRect(x: 10, y: 155, width: width-20, height: 25)
        menuLabel.text = "Menus:"
        menuLabel.font = UIFont(name: "Helvetica", size: 20)
        menuLabel.textAlignment = .left
        menuLabel.textColor = UIColor.black
        view.addSubview(menuLabel)
        
        //Create a counter the hard coded spacing between view elements
        var counter = 0
        //The menu buttons
        for _ in restaurant.getMenus(){
            let menuButton = UIButton(frame: CGRect(x: 10, y: 180 + 55*counter, width: Int(width-20), height: 50))
            menuButton.setTitleColor(UIColor.black, for: .normal)
            menuButton.backgroundColor = UIColor.white
            menuButton.layer.cornerRadius = 5
            menuButton.layer.borderWidth = 1
            menuButton.layer.borderColor = UIColor.black.cgColor
            menuButton.layer.shadowColor = UIColor.black.cgColor
            menuButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            menuButton.layer.masksToBounds = false
            menuButton.layer.shadowRadius = 1.0
            menuButton.layer.shadowOpacity = 0.5
            menuButton.addTarget(self, action: #selector(RestaurantView.menuButtonSelected), for: .touchDown)
            view.addSubview(menuButton)
            
            //Adds the menu buttons to the menu button array
            menuButtonList.append(menuButton)
            
            counter += 1
        }
        
        //Cuisine Tags label
        cuisineTagsLabel.frame = CGRect(x: 10, y: 180 + 55*counter, width: Int(width-20), height: 25)
        cuisineTagsLabel.text = "Cusine Tags"
        cuisineTagsLabel.font = UIFont(name: "Helvetica", size: 20)
        cuisineTagsLabel.textAlignment = .left
        cuisineTagsLabel.textColor = UIColor.black
        view.addSubview(cuisineTagsLabel)
        
        //Increment the counter for the next label to be properly spaced
        counter += 1
        
        //Cuisine Tags
        cuisineTags.frame = CGRect(x: 10, y: 180 + 55*counter-25, width: Int(width-20), height: 25)
        cuisineTags.text = restaurant.getTags()[0]
        cuisineTags.font = UIFont(name: "Helvetica", size: 12)
        cuisineTags.textAlignment = .left
        cuisineTags.textColor = UIColor.gray
        view.addSubview(cuisineTags)
        
        //Increment the counter for the next label to be properly spaced
        //counter += 1
        
        //Get directions Button
        directionsButton.frame = CGRect(x: 5, y: 180 + 55*counter, width: Int(width-50), height: 50)
        let buttonTitleStr = NSMutableAttributedString(string:"Get Directions", attributes:attrs)
        attributedString.append(buttonTitleStr)
        directionsButton.setAttributedTitle(attributedString, for: .normal)
        directionsButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        directionsButton.setTitleColor(UIColor.blue, for: .normal)
        directionsButton.layer.cornerRadius = 5.0
        directionsButton.layer.borderWidth = 1.5
        directionsButton.contentHorizontalAlignment = .left
        latitude = String(restaurant.getLon())
        longitude = String(restaurant.getLat())
        locationName = restaurant.getName()
        directionsButton.addTarget(self, action: #selector(RestaurantView.directionButtonSelected), for: .touchDown)
        directionsButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
        directionsButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(directionsButton)
        
        //Directions Logo
        let directionsLogo = UIImageView()
        directionsLogo.frame = CGRect(x: Int(width-50), y: 180 + 55*counter + 5, width: 40, height: 40)
        directionsLogo.image = UIImage(named: "directions")
        view.addSubview(directionsLogo)
        
        //Horizontal Line
        let horLine1 = UIImageView(frame: CGRect(x: 10, y: 180 + 55*counter+50, width: Int(width-20), height: 1))
        horLine1.backgroundColor = UIColor.lightGray
        view.addSubview(horLine1)
        
        //Increment the counter for the next label to be properly spaced
        counter += 1
        
        //Call button
        callButton.frame = CGRect(x: 5, y: 180 + 55*counter, width: Int(width-50), height: 50)
        let buttonTitleStr2 = NSMutableAttributedString(string:"Call Restaurant", attributes:attrs)
        attributedString2.append(buttonTitleStr2)
        callButton.setAttributedTitle(attributedString2, for: .normal)
        callButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        callButton.setTitleColor(UIColor.blue, for: .normal)
        callButton.layer.cornerRadius = 5.0
        callButton.layer.borderWidth = 1.5
        callButton.contentHorizontalAlignment = .left
        callButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
        callButton.layer.borderColor = UIColor.white.cgColor
        phoneNumber = restaurant.getPhoneNumber()
        callButton.addTarget(self, action: #selector(RestaurantView.callButtonSelected), for: .touchDown)
        view.addSubview(callButton)
        
        //Call Logo
        let callLogo = UIImageView()
        callLogo.frame = CGRect(x: Int(width-50), y: 180 + 55*counter + 5, width: 40, height: 40)
        callLogo.image = UIImage(named: "call")
        view.addSubview(callLogo)
        
        //Horizontal Line
        let horLine2 = UIImageView(frame: CGRect(x: 10, y: 180 + 55*counter+50, width: Int(width-20), height: 1))
        horLine2.backgroundColor = UIColor.lightGray
        view.addSubview(horLine2)
        
        //Increment the counter for the next label to be properly spaced
        counter += 1
        
        //Go to Website button
        websiteButton.frame = CGRect(x: 5, y: 180 + 55*counter, width: Int(width-50), height: 50)
        websiteButton.setTitle("Go to Website", for: .normal)
        let buttonTitleStr3 = NSMutableAttributedString(string:"Go To Website", attributes:attrs)
        attributedString3.append(buttonTitleStr3)
        websiteButton.setAttributedTitle(attributedString3, for: .normal)
        websiteButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        websiteButton.setTitleColor(UIColor.blue, for: .normal)
        websiteButton.layer.cornerRadius = 5.0
        websiteButton.layer.borderWidth = 1.5
        websiteButton.contentHorizontalAlignment = .left
        url = restaurant.getUrl()
        websiteButton.addTarget(self, action: #selector(RestaurantView.websiteButtonSelected), for: .touchDown)
        websiteButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
        websiteButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(websiteButton)
        
        //Website Logo
        let websiteLogo = UIImageView()
        websiteLogo.frame = CGRect(x: Int(width-50), y: 180 + 55*counter + 5, width: 40, height: 40)
        websiteLogo.image = UIImage(named: "website")
        view.addSubview(websiteLogo)
        
        //Horizontal Line
        let horLine3 = UIImageView(frame: CGRect(x: 10, y: 180 + 55*counter+50, width: Int(width-20), height: 1))
        horLine3.backgroundColor = UIColor.lightGray
        view.addSubview(horLine3)
        
        
        return view
    }
    
    //Function for when the call button is elected. It calls the restaurant phone number when the button is clicked.
    func callButtonSelected(){
        if let url = NSURL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    //Function for when the direction button is selected. It redirects the user to the directions app with the address from the restaurant.
    func directionButtonSelected(){
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(longitude
            )!, CLLocationDegrees(latitude)!)
        let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: options)
    }
    
    //Function for when the website button is selected. It redirects the user to the restaurant's website
    func websiteButtonSelected(){
        UIApplication.shared.openURL(NSURL(string: url)! as URL)
    }
    
    //Get function for the menu buttons array
    func getMenuButtons()->[UIButton]{
        return (menuButtonList)
    }
    
    //Function that sets the title for the menu buttons. This function is used after the menu data is called from the API. The resaon for this function is because the data loads slower than the view, so the buttons are initially blank, but then their titles are loaded soon after the view is initialized.
    func menuButtonSelected(sender: UIButton){
        let menu = currentRestaurantMenus.getMenu(name: (sender.titleLabel?.text!)!)
        delegate?.TransitionToMenu(menu: menu!)
    }

}


