//
//  ProfileView.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

public class ProfileView{
    let view = UIView()
    var logoutButton = UIButton()
     weak var delegate: LogoutDelegate?
    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Create all the attributes in the correct location
        logoutButton = UIButton(frame: CGRect(x: width/2-100, y: height*3/5+120, width: 200, height: 50))
        
        //Login button properties
        logoutButton.backgroundColor = UIColor.red
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        logoutButton.layer.cornerRadius = 5.0
        logoutButton.layer.borderWidth = 1.5
        logoutButton.layer.borderColor = UIColor.red.cgColor
        logoutButton.addTarget(self, action: #selector(ProfileView.logoutButtonPressed), for: .touchDown)
        
        //Add the attributes to the view
        view.addSubview(logoutButton)
        
        return view
    }
    
    @objc func logoutButtonPressed(){
        delegate?.Logout()
    }
}
