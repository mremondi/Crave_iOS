//
//  FavoritesViewController.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "More"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 34)!,  NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
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
        
        
        // Do any additional setup after loading the view.
    }
    
    func goToSearch(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "search") as? SearchViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToFavorites(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cravings") as? CravingsViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToProfile(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func goToNearMe(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nearMe") as? NearMeViewController
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
