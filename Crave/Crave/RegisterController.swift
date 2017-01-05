//
//  RegisterController.swift
//  Crave
//
//  Created by Michael Remondi on 1/5/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

	@IBOutlet weak var etEmail: UITextField!
	@IBOutlet weak var etPassword1: UITextField!
	@IBOutlet weak var etPassword2: UITextField!
	@IBOutlet weak var btnRegister: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.title = "Crave"
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Milkshake", size: 40)!,  NSForegroundColorAttributeName: UIColor.white]
		navigationController?.navigationBar.barTintColor = UIColor(red: 0.737, green: 0.086, blue: 0.212, alpha: 1.0)
		navigationController?.isNavigationBarHidden = false
		navigationItem.hidesBackButton = true
		
		btnRegister.addTarget(self, action: #selector(self.btnRegisterClick), for: .touchDown)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.finishLogin), name:NSNotification.Name(rawValue: "RegisterIdentifier"), object: nil)

		
		self.hideKeyboardWhenTappedAround()
		self.dismissKeyboard()
    }
	
	@objc func btnRegisterClick(){
		register(email: etEmail.text!, password1: etPassword1.text!, password2: etPassword2.text!)
	}

	func register(email: String, password1: String, password2: String){
		VCUtils.showActivityIndicator(uiView: self.view)
		if(password1 != password2){
			let alert = UIAlertController(title: "Error",
			                              message:"Ensure passwords match",
			                              preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)

		}
		requests.requestRegister(email: email, password: password1)
	}
	
	@objc func finishLogin(notification: Notification){
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
			                              message:"Register failure. Please make sure to use a unique email.",
			                              preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
			
			//If the login is a success
		else{
			NotificationCenter.default.removeObserver(self)
			let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
			self.navigationController?.pushViewController(vc!, animated: true)
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
