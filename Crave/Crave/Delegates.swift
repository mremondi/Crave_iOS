//
//  Delegates.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit

protocol LoginInitializationDelegate: class {
    func Login(username: String, password: String)
}

protocol LogoutDelegate: class{
    func Logout()
}
