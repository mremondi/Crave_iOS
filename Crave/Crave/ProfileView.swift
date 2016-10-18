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
    var changePasswordButton = UIButton()
    var newPassword = UITextField()
    var confirmPassword = UITextField()
    weak var delegate: ProfileDelegate?
    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Name title
        let nameTitle = UILabel(frame: CGRect(x: width/2-155, y: height/5+25, width: 50, height: 50))
        nameTitle.text = "Name: "
        nameTitle.textAlignment = .right
        nameTitle.adjustsFontSizeToFitWidth = true
        view.addSubview(nameTitle)
        
        //Email title
        let emailTitle = UILabel(frame: CGRect(x: width/2-155, y: height/5-35, width: 50, height: 50))
        emailTitle.text = "Email: "
        emailTitle.textAlignment = .right
        emailTitle.adjustsFontSizeToFitWidth = true
        view.addSubview(emailTitle)
        
        //New title
        let newTitle = UILabel(frame: CGRect(x: width/2-155, y: height*2/5+55, width: 50, height: 50))
        newTitle.text = "New: "
        newTitle.textAlignment = .right
        newTitle.adjustsFontSizeToFitWidth = true
        view.addSubview(newTitle)
        
        //Confirm title
        let confirmTitle = UILabel(frame: CGRect(x: width/2-155, y: height*2/5+115, width: 50, height: 50))
        confirmTitle.text = "Confirm: "
        confirmTitle.textAlignment = .right
        confirmTitle.adjustsFontSizeToFitWidth = true
        view.addSubview(confirmTitle)
        
        //Email text display
        emailLabel = UITextField(frame: CGRect(x: width/2-100, y: height/5-35, width: 200, height: 50))
        emailLabel.text = profile.getEmail()
        emailLabel.layer.cornerRadius = 5.0;
        emailLabel.layer.borderWidth = 1.5
        //emailLabel.isSecureTextEntry = true
        emailLabel.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        emailLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(emailLabel)
        
        //Name text display
        nameLabel = UITextField(frame: CGRect(x: width/2-100, y: height/5+25, width: 200, height: 50))
        nameLabel.text = profile.getName()
        nameLabel.layer.cornerRadius = 5.0;
        nameLabel.layer.borderWidth = 1.5
        //nameLabel.isSecureTextEntry = true
        nameLabel.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        nameLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(nameLabel)
        
        //New Password text display
        newPassword = UITextField(frame: CGRect(x: width/2-100, y: height*2/5+55, width: 200, height: 50))
        newPassword.text = ""
        newPassword.layer.cornerRadius = 5.0;
        newPassword.layer.borderWidth = 1.5
        newPassword.isSecureTextEntry = true
        newPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        newPassword.adjustsFontSizeToFitWidth = true
        view.addSubview(newPassword)
        
        //Confirm Password text display
        confirmPassword = UITextField(frame: CGRect(x: width/2-100, y: height*2/5+115, width: 200, height: 50))
        confirmPassword.text = ""
        confirmPassword.layer.cornerRadius = 5.0;
        confirmPassword.layer.borderWidth = 1.5
        confirmPassword.isSecureTextEntry = true
        confirmPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        confirmPassword.adjustsFontSizeToFitWidth = true
        view.addSubview(confirmPassword)
        
        //Update button properties
        updateButton = UIButton(frame: CGRect(x: width/2-100, y: height/5+85, width: 200, height: 50))
        updateButton.backgroundColor = UIColor.blue
        updateButton.setTitle("Update", for: .normal)
        updateButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        updateButton.layer.cornerRadius = 5.0
        updateButton.layer.borderWidth = 1.5
        updateButton.layer.borderColor = UIColor.blue.cgColor
        updateButton.addTarget(self, action: #selector(ProfileView.updateButtonPressed), for: .touchDown)
        view.addSubview(updateButton)
        
        //Change password properties
        changePasswordButton = UIButton(frame: CGRect(x: width/2-100, y: height*3/5+60, width: 200, height: 50))
        changePasswordButton.backgroundColor = UIColor.blue
        changePasswordButton.setTitle("Change Password", for: .normal)
        changePasswordButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        changePasswordButton.layer.cornerRadius = 5.0
        changePasswordButton.layer.borderWidth = 1.5
        changePasswordButton.layer.borderColor = UIColor.blue.cgColor
        changePasswordButton.addTarget(self, action: #selector(ProfileView.changePasswordButtonPressed), for: .touchDown)
        view.addSubview(changePasswordButton)

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
    
    @objc func changePasswordButtonPressed(){
        if ((confirmPassword.text == newPassword.text)&&(newPassword.text != "")){
            delegate?.ChangePassword(password: confirmPassword.text!)
        }
        
        else if (newPassword.text == ""){
            delegate?.passwordMismatch(error: "Blank password entered.")
        }
            
        else{
            delegate?.passwordMismatch(error: "Passwords do not match.")
        }
    }
}

