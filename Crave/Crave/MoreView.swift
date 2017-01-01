//
//  RestaurantView.swift
//  Crave
//
//  Created by Robert Durst on 11/25/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MoreView: UIView {
    
    
    let view = UIView()
    let myProfileButton = UIButton()
    let aboutUsButton = UIButton()
    weak var delegate: MoreTransitionDelegate?
    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        //let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Get My Profile Button
        myProfileButton.frame = CGRect(x: 5, y: 65, width: Int(width-50), height: 50)
        myProfileButton.setTitle("My Profile", for: [])
        myProfileButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        myProfileButton.setTitleColor(UIColor.lightGray, for: .normal)
        myProfileButton.layer.cornerRadius = 5.0
        myProfileButton.layer.borderWidth = 1.5
        myProfileButton.contentHorizontalAlignment = .left
        myProfileButton.addTarget(self, action: #selector(MoreView.myProfileButtonSelected), for: .touchDown)
        myProfileButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
        myProfileButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(myProfileButton)
        
        //My Profile Logo
        let myProfileButtonLogo = UIImageView()
        myProfileButtonLogo.frame = CGRect(x: Int(width-50), y: 65, width: 40, height: 40)
        myProfileButtonLogo.image = UIImage(named: "profile")
        view.addSubview(myProfileButtonLogo)
        
        //Horizontal Line
        let horLine1 = UIImageView(frame: CGRect(x: 10, y: 105, width: Int(width-20), height: 1))
        horLine1.backgroundColor = UIColor.lightGray
        view.addSubview(horLine1)
        
        //Get directions Button
        aboutUsButton.frame = CGRect(x: 5, y: 110, width: Int(width-50), height: 50)
        aboutUsButton.setTitle("About Us", for: [])
        aboutUsButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        aboutUsButton.setTitleColor(UIColor.lightGray, for: .normal)
        aboutUsButton.layer.cornerRadius = 5.0
        aboutUsButton.layer.borderWidth = 1.5
        aboutUsButton.contentHorizontalAlignment = .left
        aboutUsButton.addTarget(self, action: #selector(MoreView.aboutUsButtonSelected), for: .touchDown)
        aboutUsButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
        aboutUsButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(aboutUsButton)
        
        //Directions Logo
        let aboutUsButtonLogo = UIImageView()
        aboutUsButtonLogo.frame = CGRect(x: Int(width-50), y: 110, width: 40, height: 40)
        aboutUsButtonLogo.image = UIImage(named: "aboutUs")
        view.addSubview(aboutUsButtonLogo)
        
        //Horizontal Line
        let horLine2 = UIImageView(frame: CGRect(x: 10, y: 150, width: Int(width-20), height: 1))
        horLine2.backgroundColor = UIColor.lightGray
        view.addSubview(horLine2)
        

        
        
        return view
    }
    
    func myProfileButtonSelected(){
        delegate?.ProfileButtonClicked()
    }
    
    func aboutUsButtonSelected(){
        delegate?.AboutUSButtonClicked()
    }
    
    
    
}


