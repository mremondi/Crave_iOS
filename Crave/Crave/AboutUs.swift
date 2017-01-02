//
//  AboutUs.swift
//  Crave
//
//  Created by Robert Durst on 11/27/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

class AboutUs: UIView {

    //Initialize all the element fields for the view
    let view = UIView()
    let craveTitleLabel = UILabel()
    let authorLabel = UILabel()
    let contactLabel = UILabel()
    let emailButton = UIButton()
    
    //This creates the underlined string format for the email in the (contact us label/button)
    var attrs = [
    NSFontAttributeName : UIFont.systemFont(ofSize: 15.0),
    NSForegroundColorAttributeName : UIColor.red,
    NSUnderlineStyleAttributeName : 1] as [String : Any]
    var attributedString = NSMutableAttributedString(string:"")

    
    func create()->UIView{
    
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        view.backgroundColor = UIColor.white
        
        //Crave Title Label
        craveTitleLabel.frame = CGRect(x: 0, y: height/2-100, width: width, height: 100)
        craveTitleLabel.text = "Crave"
        craveTitleLabel.font = UIFont(name: "Milkshake", size: 75)
        craveTitleLabel.textColor = UIColor.red
        craveTitleLabel.textAlignment = .center
        view.addSubview(craveTitleLabel)
        
        //Author Label
        contactLabel.frame = CGRect(x: 0, y: height/2 + 75, width: width, height: 25)
        contactLabel.text = "Michael Remondi 2016"
        contactLabel.font = contactLabel.font.withSize(15)
        contactLabel.textAlignment = .center
        view.addSubview(contactLabel)
        
        //Contact Label
        authorLabel.frame = CGRect(x: 0, y: height/2 + 100, width: width*2/5-30, height: 25)
        authorLabel.text = "Contact Us: "
        authorLabel.font = contactLabel.font.withSize(15)
        authorLabel.textAlignment = .right
        view.addSubview(authorLabel)
        
        //Email Button
        emailButton.frame = CGRect(x: width*2/5-30, y:  height/2 + 100, width: width*3/5, height: 25)
        let buttonTitleStr = NSMutableAttributedString(string:"mikeremondi@gmail.com", attributes:attrs)
        attributedString.append(buttonTitleStr)
        emailButton.setAttributedTitle(attributedString, for: .normal)
        emailButton.setTitleColor(UIColor.red, for: [])
        emailButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        emailButton.titleLabel?.textAlignment = .left
        view.addSubview(emailButton)
        
        
        
        
        return view
    }

}
