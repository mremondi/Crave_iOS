//
//  FavoritesViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The view controller with the "more" options, essentially the settings that allow for the user to either see the contact information or change some of their user information. This section will likely be added to later in app development as more features are added.

import UIKit

class MoreViewController: UIViewController, MoreTransitionDelegate {
    
    //Initilize the view variable here as a field so that it may be referenced by multiple functions below
    let moreView = MoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Connect the delegate from teh view to the view controller
        moreView.delegate = self
        
        //Sets the size of the view so that the view goes beyond the size of the screen, since it is a scroll view it has content beyond the size of the screen. Here I have hard coded the size of the screen for the worst case scenario.
        self.navigationItem.title = "More"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        //This section creates the four buttons used for navigation at the bottom of the view and then sets these buttons to the bottom nav bar
        //______________________________________________________________________________________________________________________
        let button = UIView()
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 40)
        
        let buttonImage = UIImageView()
        buttonImage.image = UIImage(named: "More")
        buttonImage.frame = CGRect(x: 6, y: 0, width: 36-12, height: 22)
        button.addSubview(buttonImage)
        
        let buttonText = UITextView()
        buttonText.text = "More"
        buttonText.font = UIFont(name: "Helvetica", size: 11)
        buttonText.frame = CGRect(x: -10, y: 20, width: 56, height:20)
        buttonText.backgroundColor = UIColor.red
        buttonText.textColor = UIColor.white
        buttonText.contentInset = UIEdgeInsetsMake(-5.0,0.0,0,0.0)
        buttonText.textAlignment = .center
        button.addSubview(buttonText)
        
        let barButton = UIBarButtonItem(customView: button)
        
        let button2 = UIButton()
        //set image for button
        button2.setImage(UIImage(named: "Map"), for: UIControlState())
        //set frame
        button2.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        button2.addTarget(self, action: #selector(MoreViewController.goToNearMe), for: .touchDown)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        let button3 = UIButton()
        //set image for button
        button3.setImage(UIImage(named: "Search"), for: UIControlState())
        //set frame
        button3.addTarget(self, action: #selector(MoreViewController.goToSearch), for: .touchDown)
        button3.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        let barButton3 = UIBarButtonItem(customView: button3)
        
        let button4 = UIButton()
        //set image for button
        button4.setImage(UIImage(named: "Favorites"), for: UIControlState())
        //set frame
        button4.addTarget(self, action: #selector(MoreViewController.goToFavorites), for: .touchDown)
        button4.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        
        let barButton4 = UIBarButtonItem(customView: button4)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let navigationBarButtonItemsArray = [barButton2, spacer, barButton3,spacer,barButton4,spacer,barButton]
        
        self.navigationController?.isToolbarHidden = false
        self.setToolbarItems(navigationBarButtonItemsArray, animated: true)
        self.navigationController?.toolbar.barTintColor = UIColor.red
        //______________________________________________________________________________________________________________________
        
        //Connect the view from the moreView to the view in the moreViewController
        self.view = moreView.create()
        
        // Do any additional setup after loading the view.
    }
    
    //This section has the button actions for the nav bar buttons on the bottom of the page
    //______________________________________________________________________________________________________________________
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
    
    func goToNearMe(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    //______________________________________________________________________________________________________________________

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function for when the profile button is clicked. Navigates from the more view controller to the profile view controller
    func ProfileButtonClicked() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    //Function for when the profile button is clicked. Navigates from the more view controller to the about us view controller
    func AboutUSButtonClicked() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "aboutUs") as? AboutUsViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
}
