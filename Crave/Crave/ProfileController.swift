//
//  ProfileController.swift
//  Crave
//
//  Created by Michael Remondi on 1/5/17.
//  Copyright © 2017 Crave. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, NavViewInterface {

	@IBOutlet weak var etEmail: UITextField!
	@IBOutlet weak var etName: UITextField!
	@IBOutlet weak var etPassword1: UITextField!
	@IBOutlet weak var etPassword2: UITextField!
	@IBOutlet weak var btnUpdate: UIButton!
	@IBOutlet weak var btnChangePassword: UIButton!
	@IBOutlet weak var btnLogout: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Listener for the profile
		NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name:NSNotification.Name(rawValue: "ProfileIdentifier"), object: nil)
		
		etEmail.text = profile.getEmail()
		etName.text = profile.getName()
		
		btnUpdate.addTarget(self, action: #selector(self.updateButtonPressed), for: .touchDown)
		
		btnChangePassword.addTarget(self, action: #selector(self.changePasswordButtonPressed), for: .touchDown)
		
		btnLogout.addTarget(self, action: #selector(self.logoutButtonPressed), for: .touchDown)
		
		let _ = TopBarAdapter(viewController: self, title: nil)
		let _ = BottomBarAdapter(viewController: self)        

		// Do any additional setup after loading the view.
    }

	//Function that calls the view controller function for when the logout button is pressed
	@objc func logoutButtonPressed(){
		profile.clear()
		requests.requestLogout()
		let defaults = UserDefaults.standard
		defaults.set(Optional.none, forKey: "isLoggedIn")
		let nav = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
		let vc = nav.topViewController as! LogInController
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	//Function that calls the view controller function for when the update button is pressed
	@objc func updateButtonPressed(){
		requests.requestUpdate(email: etEmail.text!, name: etName.text!, id: profile.getID())
	}
	
	//Function thats calls the view controller function for when the change password button is pressed. However, this function will call a different function depending on whether or not the passwords are matching/blank
	@objc func changePasswordButtonPressed(){
		if ((etPassword2.text == etPassword1.text)&&(etPassword1.text != "")){
			requests.requestChangePassword(password: etPassword1.text!, id: profile.getID())
		}
			
		else if (etPassword1.text == ""){
			self.passwordMismatch(error: "Blank password entered.")
		}
			
		else{
			self.passwordMismatch(error: "Passwords do not match.")
		}
	}
	
	//Refreshes the information in the screen, signifying the successful refresh withan alert
	func refresh(){
		let alert = UIAlertController(title: "Success",
		                              message:"Information changed.",
		                              preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
        
        // Why is this here? viewDidLoad should not be manually called
		self.viewDidLoad()
	}
	
	func passwordMismatch(error: String){
		let alert = UIAlertController(title: "Error",
		                              message:error,
		                              preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	func goToSearch(){
		let vc = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as? SearchController
		self.navigationController?.pushViewController(vc!, animated: false)
	}

	
	func goToFavorites(){
		let vc = UIStoryboard(name: "Favorites", bundle: nil).instantiateInitialViewController() as? FavoritesController
		requests.requestUserRatings(id: profile.getID(), vc: vc!)
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToMore(){
		let vc = UIStoryboard(name: "More", bundle: nil).instantiateInitialViewController() as? MoreController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	func goToNearMe(){
		let vc = UIStoryboard(name: "NearMe", bundle: nil).instantiateInitialViewController() as? NearMeViewController
		self.navigationController?.pushViewController(vc!, animated: false)
		
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
