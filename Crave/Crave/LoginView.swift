//
//  LoginView.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

public class LoginView{

    let view = UIView()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    weak var delegate: LoginInitializationDelegate?
    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Create all the attributes in the correct location
        emailTextField = UITextField(frame: CGRect(x: width/2-125, y: height/5, width: 250, height: 50))
        passwordTextField = UITextField(frame: CGRect(x: width/2-125, y: height/5+60, width: 250, height: 50))
        loginButton = UIButton(frame: CGRect(x: width/2-100, y: height/5+120, width: 200, height: 50))
        
        //Email text field properties
        emailTextField.placeholder = "email"
        emailTextField.layer.cornerRadius = 5.0
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        emailTextField.adjustsFontSizeToFitWidth = true
        
        //Password text field properties
        passwordTextField.placeholder = "password"
        passwordTextField.layer.cornerRadius = 5.0;
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordTextField.adjustsFontSizeToFitWidth = true
        
        //Login button properties
        loginButton.backgroundColor = UIColor.red
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        loginButton.layer.cornerRadius = 5.0
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = UIColor.red.cgColor
        loginButton.addTarget(self, action: #selector(LoginView.loginButtonPressed), for: .touchDown)
        
        //Add all the attributes to the view
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        return view
    }
    
    @objc func loginButtonPressed(){
        delegate?.Login(username: emailTextField.text!, password: passwordTextField.text!)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
