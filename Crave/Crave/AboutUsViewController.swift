//
//  AboutUsViewController.swift
//  Crave
//
//  Created by Robert Durst on 11/27/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    let aboutUs = AboutUs()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "About Us"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        let button = UIButton()
        //set image for button
        button.setImage(UIImage(named: "Map"), for: UIControlState())
        //set frame
        button.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        button.addTarget(self, action: #selector(AboutUsViewController.goToNearMe), for: .touchDown)
        let barButton = UIBarButtonItem(customView: button)
        
        let button2 = UIButton()
        //set image for button
        button2.setImage(UIImage(named: "Search"), for: UIControlState())
        //set frame
        button2.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        button2.addTarget(self, action: #selector(AboutUsViewController.goToSearch), for: .touchDown)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        let button3 = UIButton()
        //set image for button
        button3.setImage(UIImage(named: "Favorites"), for: UIControlState())
        //set frame
        button3.addTarget(self, action: #selector(AboutUsViewController.goToFavorites), for: .touchDown)
        button3.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        let barButton3 = UIBarButtonItem(customView: button3)
        
        
        let button4 = UIButton()
        //set image for button
        button4.setImage(UIImage(named: "More"), for: UIControlState())
        //set frame
        button4.addTarget(self, action: #selector(AboutUsViewController.goToMore), for: .touchDown)
        button4.frame = CGRect(x: 6, y: -5, width: 36-12, height: 22)
        
        let barButton4 = UIBarButtonItem(customView: button4)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let navigationBarButtonItemsArray = [barButton, spacer, barButton2,spacer,barButton3,spacer,barButton4]
        
        self.navigationController?.isToolbarHidden = false
        self.setToolbarItems(navigationBarButtonItemsArray, animated: true)
        self.navigationController?.toolbar.barTintColor = UIColor.red
        
        self.view = aboutUs.create()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "more") as? MoreViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToNearMe(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
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