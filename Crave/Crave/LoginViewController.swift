//
//  LoginViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The initial login view.

import UIKit

let locationManagerClass = LocationManager()

class LoginViewController: UIViewController, LoginInitializationDelegate {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //These initialize properties of the view, setting the title, the title format, the color of the navigation bar, hiding the nav bar back button, and making sure the nav bar is not hidden
        self.navigationItem.title = "Crave"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Milkshake", size: 40)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor.red
        
        //Connect the delegate from the LoginView to the LoginViewController
        loginView.delegate = self
        
        //Set the view of the view controller to the view of its view
        self.view = loginView.create()
        
        //Initialize the two functions for UX regarding the keyboard
        self.hideKeyboardWhenTappedAround()
        self.dismissKeyboard()
        
        //Listener for the login, if successful or not
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.finishLogin), name:NSNotification.Name(rawValue: "LoginIdentifier"), object: nil)
        
        //Call the function to ask for location permissions if not already obtained
        locationManagerClass.enableLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Login(username: String, password: String) {
        VCUtils.showActivityIndicator(uiView: self.view)
        requests.requestLogin(email: username, password: password)
    }
    
    //The function that deals with the outcome of verifying the login information provided by the user. This function is triggered by a notifcation sent from the finished request. From this notification is a message about the staties of the login.
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
            NotificationCenter.default.removeObserver(self)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
