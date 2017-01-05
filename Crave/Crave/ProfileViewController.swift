//
//  ProfileViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The view for the user's profile where they can see/change their name/email, change their password, and logout

import UIKit

class ProfileViewController: UIViewController, ProfileDelegate, NavViewInterface  {

     //The initialized ProfileView field, created here since it will be used on multiple functions below
     let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //These initialize properties of the view, setting the title, the title format, the color of the navigation bar, hiding the nav bar back button, and making sure the nav bar is not hidden
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        
        //Listener for the profile
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.refresh), name:NSNotification.Name(rawValue: "ProfileIdentifier"), object: nil)
        
        //Connect the delegate from the ProfileView to the ProfileViewController
        profileView.delegate = self
        
        //Set the view from the ProfileView to the view of the ProfileViewController
        self.view = profileView.create()
        
        self.navigationController?.toolbar.barTintColor = UIColor.red
		
		let _ = BottomBarAdapter(viewController: self)        
        // Do any additional setup after loading the view.
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The logout function. It clears the profile object that was created after login, calls the logout API call, then it navigates to the login view controller
    func Logout() {
        profile.clear()
        requests.requestLogout()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //Updates the name/email of the user by calling the appropriate API call
    func Update(email: String, name: String) {
        requests.requestUpdate(email: email, name: name, id: profile.getID())
    }
    
    //Changes the user's password by calling the appropriate API call
    func ChangePassword(password: String) {
        requests.requestChangePassword(password: password, id: profile.getID())
    }
    
    //Refreshes the information in the screen, signifying the successful refresh withan alert
    func refresh(){
        let alert = UIAlertController(title: "Success",
                                      message:"Information changed.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.viewDidLoad()
    }
    
    //Throws an unsuccesful alert if the passwords, for the proposed new password, mismatch
    func passwordMismatch(error: String){
        let alert = UIAlertController(title: "Error",
                                      message:error,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

	func goToSearch(){
		requests.getAllItems()
		
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchViewController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	func goToFavorites(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "cravings") as? CravingsViewController
		requests.requestUserRatings(id: profile.getID(), vc: vc!)
		self.navigationController?.pushViewController(vc!, animated: false)
	}
	
	func goToMore(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
	
	func goToNearMe(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
		self.navigationController?.pushViewController(vc!, animated: false)
		
	}
}
