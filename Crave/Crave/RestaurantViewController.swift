//
//  RestaurantViewController.swift
//  Crave
//
//  Created by Robert Durst on 11/25/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, RestaurantTransitionDelegate {
    
    //Initialization of some of the view controller's element fields
    var restID = ""
    var menuButtonList = [UIButton]()
    let restaurantView = RestaurantView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These initialize properties of the view, setting the title, the title format, the color of the navigation bar, hiding the nav bar back button, and making sure the nav bar is not hidden
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
        self.navigationItem.title = nearbyRestaurants.getRestaurant(id: restID)?.getName()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 20)!,  NSForegroundColorAttributeName: UIColor.white]
        
        //Connect the view's delegate to the view controller
        restaurantView.delegate = self
        
        //Set the view from the view to the view controller's view
        let view = restaurantView.create(id: restID)
        //Sets the size of the view so that the view goes beyond the size of the screen, since it is a scroll view it has content beyond the size of the screen. Here I have hard coded the size of the screen for the worst case scenario.
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+200)
        
        //Calls the custom back bar function.
        SetBackBarButtonCustom()
        
        //Set the view to the RestaurantView's view
        self.view = view
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The function that navigates from this view controller to the "main" view controller (the nearMe view)
    func goToNearMe(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }

    //Function that is called to update the menu button titles after the menu data is receieved from teh API calls
    func updateMenuButtonTitles(){
        (menuButtonList) = restaurantView.getMenuButtons()

        var counter = 0
        for button in currentRestaurantMenus.getCurrentRestaurantMenus(){
            menuButtonList[counter].setTitle(button.getName(), for: [])
            counter += 1
        }
        
    }
    
    //Function that creates the custom back button. The custom back button navigates back to the nearMe view. While a normal back button would also navigate back to this view, for some reason reloading the narMe view instead of just navigating back to it works better. Reason for this is still unknown.
    func SetBackBarButtonCustom()
    {
        //Initialising "back button"
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back_arrow"), for: UIControlState.normal)
        btnLeftMenu.addTarget(self, action: "onClickBack", for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    //The function that calls the navigation comman linked to the custom back button, yeah †his is a function that calls a function, kind of ridiculuous but will be changed later.
    func onClickBack()
    {
        goToNearMe()
    }
    
    //The function that deals with the transition from the restaurant to one of its menus
    func TransitionToMenu(menu: Menu) {
        
        //Create the variable for the view controller
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as? MenuViewController
        
        //Initialize some elements of the menu view controller with data from the menu
        vc?.title = menu.getName()
        vc?.menuSections = menu.getSections()
        
        //Navigate to the menu view controller
        self.navigationController?.pushViewController(vc!, animated: false)
    }

}
