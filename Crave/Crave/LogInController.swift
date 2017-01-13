//
//  LogInController.swift
//  Crave
//
//  Created by Michael Remondi on 1/5/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

let locationManagerClass = LocationManager()

class LogInController: UIViewController, LoginInitializationDelegate {

	@IBOutlet weak var etEmail: UITextField!
	@IBOutlet weak var etPassword: UITextField!
	@IBOutlet weak var btnLogIn: UIButton!
	@IBOutlet weak var btnRegister: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let _ = TopBarAdapter(viewController: self, title: "Crave")
		
		btnLogIn.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchDown)
		btnRegister.addTarget(self, action: #selector(self.btnRegisterClick), for: .touchDown)
		
		let defaults = UserDefaults.standard
		if (defaults.string(forKey: "isLoggedIn") == Optional.none){
			if(defaults.string(forKey: "email") != Optional.none){
				etEmail.text = defaults.string(forKey: "email")!
			}
			if (defaults.string(forKey: "password") != Optional.none){
				etPassword.text = defaults.string(forKey: "password")!
			}
		}
		else{
			if(defaults.string(forKey: "email") != Optional.none && defaults.string(forKey: "password") != Optional.none){
				let email = defaults.string(forKey: "email")
				let password = defaults.string(forKey: "password")
				login(email: email!, password: password!)
			}
		}
		
		NotificationCenter.default.addObserver(self, selector: #selector(LogInController.finishLogin), name:NSNotification.Name(rawValue: "LoginIdentifier"), object: nil)
		
		self.hideKeyboardWhenTappedAround()
		self.dismissKeyboard()
		
		locationManagerClass.enableLocation()

		
	}
	
	@objc func loginButtonPressed(){
		login(email: etEmail.text!, password: etPassword.text!)
	}
	
	@objc func btnRegisterClick(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "register") as? RegisterController
		self.navigationController?.pushViewController(vc!, animated: true)
	}

	func login(email: String, password: String) {
		VCUtils.showActivityIndicator(uiView: self.view)
		requests.requestLogin(email: email, password: password)
	}
		
	func finishLogin(notification: Notification){
		guard let userInfo = notification.userInfo,
			let message  = userInfo["Result"] as? String else {
				print("No userInfo found in notification")
				return
		}
		
		//Hides the activity indicator
		VCUtils.hideActivityIndicator(uiView: self.view)
		
		//If the login is a failure
		if (message == "Fail"){
			let alert = UIAlertController(title: "Error",
			                              message:"Incorrect password and/or email.",
			                              preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
			
		//If the login is a success
		else{
			
			let defaults = UserDefaults.standard
			defaults.set(etEmail.text!, forKey: "email")
			defaults.set(etPassword.text!, forKey: "password")
			defaults.set("loggedIn", forKey: "isLoggedIn")
			NotificationCenter.default.removeObserver(self)
			let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
			self.navigationController?.pushViewController(vc!, animated: true)
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
