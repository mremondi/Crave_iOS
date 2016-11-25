//
//  ProfileViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileDelegate {

     let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        //Listener for the profile
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.refresh), name:NSNotification.Name(rawValue: "ProfileIdentifier"), object: nil)
        
    

        profileView.delegate = self
        self.view = profileView.create()
        
        // Do any additional setup after loading the view.
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Logout() {
        profile.clear()
        requests.requestLogout()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func Update(email: String, name: String) {
        requests.requestUpdate(email: email, name: name, id: profile.getID())
    }
    
    func ChangePassword(password: String) {
        requests.requestChangePassword(password: password, id: profile.getID())
    }
    
    func refresh(){
        let alert = UIAlertController(title: "Success",
                                      message:"Information changed.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.viewDidLoad()
    }
    
    func passwordMismatch(error: String){
        let alert = UIAlertController(title: "Error",
                                      message:error,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
