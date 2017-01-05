//
//  Delegates.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// The delegates for communication between the view controller classes and their corresponding view class

import UIKit

protocol LoginInitializationDelegate: class {
    func Login(username: String, password: String)
}

protocol ProfileDelegate: class{
    func Logout()
    func Update(email: String, name: String)
    func ChangePassword(password: String)
    func passwordMismatch(error: String)
}

protocol MapTransitionDelegate: class{
    func InfoWindowClicked(id: String)
}

protocol MoreTransitionDelegate: class{
    func btnAboutClick()
    func btnProfileClick()
}

protocol RestaurantTransitionDelegate: class{
    func TransitionToMenu(menu: Menu)
}

protocol MenuTransitionDelegate: class{
    func TransitionToItem(menuItemID: String, menuItemSection: String)
}

protocol ItemTransitionDelegate: class{
    func TransitionToPopup()
}
