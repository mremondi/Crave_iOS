//
//  MenuViewController.swift
//  Crave
//
//  Created by Robert Durst on 12/30/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, MenuTransitionDelegate {

    let menuView = MenuView()
    
    var menuSections = [MenuSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = menuView.create(sections: menuSections)
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+3700)
        
        menuView.delegate = self
        
        self.view = view
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func TransitionToItem(menuItemID: String, menuItemSection: String) {
        
        var curSection = menuSections[0]
        
        for section in menuSections{
            if (section.getSectionName() == menuItemSection){
                curSection = section
            }
        }
        
        let curItem = curSection.getItem(id: menuItemID)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "item") as? ItemViewController
        
        vc?.title = curItem.name
        vc?.item = curItem
        
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
