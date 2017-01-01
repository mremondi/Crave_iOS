//
//  RestaurantViewController.swift
//  Crave
//
//  Created by Robert Durst on 11/25/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, RestaurantTransitionDelegate {

    var restID = ""
    var menuButtonList = [UIButton]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    let restaurantView = RestaurantView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
        self.navigationItem.title = nearbyRestaurants.getRestaurant(id: restID)?.getName()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 20)!,  NSForegroundColorAttributeName: UIColor.white]
        
        restaurantView.delegate = self
        
        let view = restaurantView.create(id: restID)
        
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+200)
        //scrollView.backgroundColor = UIColor.white
        //scrollView.touchesShouldCancel(in: scrollView)
        //scrollView.delaysContentTouches = false
        
        //scrollView.addSubview(view)
        
        SetBackBarButtonCustom()
        
        self.view = view
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToNearMe(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }

    
    func updateMenuButtonTitles(){
        (menuButtonList) = restaurantView.getMenuButtons()

        var counter = 0
        for button in currentRestaurantMenus.getCurrentRestaurantMenus(){
            menuButtonList[counter].setTitle(button.getName(), for: [])
            counter += 1
        }
        
    }
    
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
    
    func onClickBack()
    {
        goToNearMe()
    }
    
    func TransitionToMenu(menu: Menu) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as? MenuViewController
        
        vc?.title = menu.getName()
        vc?.menuSections = menu.getSections()
        
        self.navigationController?.pushViewController(vc!, animated: false)
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
