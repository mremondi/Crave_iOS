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
    var updateButton = UIButton()
    var emailLabel = UITextField()
    var nameLabel = UITextField()
    weak var delegate: ProfileDelegate?
    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Email text display
        emailLabel = UITextField(frame: CGRect(x: width/2-100, y: height/5+150, width: 200, height: 50))
        emailLabel.text = profile.getEmail()
        view.addSubview(emailLabel)
        
        //Name text display
        nameLabel = UITextField(frame: CGRect(x: width/2-100, y: height/5+120, width: 200, height: 50))
        nameLabel.text = profile.getName()
        view.addSubview(nameLabel)
        
        //Update button properties
        updateButton = UIButton(frame: CGRect(x: width/2-100, y: height*3/5+60, width: 200, height: 50))
        updateButton.backgroundColor = UIColor.red
        updateButton.setTitle("Update", for: .normal)
        updateButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        updateButton.layer.cornerRadius = 5.0
        updateButton.layer.borderWidth = 1.5
        updateButton.layer.borderColor = UIColor.red.cgColor
        updateButton.addTarget(self, action: #selector(ProfileView.updateButtonPressed), for: .touchDown)
        view.addSubview(updateButton)

        
        //Login button properties
        logoutButton = UIButton(frame: CGRect(x: width/2-100, y: height*3/5+120, width: 200, height: 50))
        logoutButton.backgroundColor = UIColor.red
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        logoutButton.layer.cornerRadius = 5.0
        logoutButton.layer.borderWidth = 1.5
        logoutButton.layer.borderColor = UIColor.red.cgColor
        logoutButton.addTarget(self, action: #selector(ProfileView.logoutButtonPressed), for: .touchDown)
        view.addSubview(logoutButton)
        
        
        
        return view
    }
    
    @objc func logoutButtonPressed(){
        delegate?.Logout()
    }
    
    @objc func updateButtonPressed(){
        delegate?.Update(email: emailLabel.text!, name: nameLabel.text!)
    }
}
