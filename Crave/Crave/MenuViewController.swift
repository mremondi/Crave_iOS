//
//  MenuViewController.swift
//  Crave
//
//  Created by Robert Durst on 12/30/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// This is the view for menus

import UIKit

class MenuViewController: UIViewController, MenuTransitionDelegate {

    let menuView = MenuView()
    
    var menuSections = [MenuSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the view to the menuView
        let view = menuView.create(sections: menuSections)
        //Sets the size of the view so that the view goes beyond the size of the screen, since it is a scroll view it has content beyond the size of the screen. Here I have hard coded the size of the screen for the worst case scenario.
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+3700)
        self.view = view
        
        //Connect the delegate in the menuView to the menuViewController
        menuView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The function that deals with the transition from the menu to the menu item
    func TransitionToItem(menuItemID: String, menuItemSection: String) {
        
        //Capture the current menu section
        var curSection = menuSections[0]
        for section in menuSections{
            if (section.getSectionName() == menuItemSection){
                curSection = section
            }
        }
        
        //Capture the curret menu item
        let curItem = curSection.getItem(id: menuItemID)
        
        //Create a variable for the item view controller
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemViewController
        
        //Initialize some values in the item view controller
        vc?.title = curItem.name
        vc?.item = curItem
        
        //Navigate to the item view controller
        self.navigationController?.pushViewController(vc!, animated: false)
    }


}
