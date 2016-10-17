//
//  LoginViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

let locationManagerClass = LocationManager()

class LoginViewController: UIViewController, LoginInitializationDelegate {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Crave"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor.red
        
        loginView.delegate = self
        self.view = loginView.create()
        self.hideKeyboardWhenTappedAround()
        
        //Listener for the login, if successful or not
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.finishLogin), name:NSNotification.Name(rawValue: "LoginIdentifier"), object: nil)
        
        locationManagerClass.enableLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Login(username: String, password: String) {
        requests.requestLogin(email: username, password: password)
    }
    
    func finishLogin(notification: Notification){
        guard let userInfo = notification.userInfo,
            let message  = userInfo["Result"] as? String else {
                print("No userInfo found in notification")
                return
        }
        
        if (message == "Fail"){
            let alert = UIAlertController(title: "Error",
                                          message:"Incorrect password and/or email.",
                preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            NotificationCenter.default.removeObserver(self)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
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
