//
//  Profile.swift
//  Crave
//
//  Created by Robert Durst on 10/17/16.
//  Copyright © 2016 Crave. All rights reserved.
//

public class Profile{
    private var id: String
    private var email: String
    //let ratings = todo["ratings"] //array
    //let profile = todo["profile"] //dictionary
    private var gender: String
    //let restaurants = profile["restaurants"] //array
    //let picture = profile["picture"] //unknown
    private var website: String
    private var name: String
    private var location: String
    
    init(id: String, email: String, gender: String, website: String, name: String, location: String) {
        self.id = id
        self.email = email
        self.gender = gender
        self.website = website
        self.name = name
        self.location = location
    }
    
    func getID()->String{
        return self.id
    }
    
    func getEmail()->String{
        return self.email
    }
    
    func getGender()->String{
        return self.gender
    }
    
    func getWebsite()->String{
        return self.website
    }
    
    func getName()->String{
        return self.name
    }
    
    func getLocation()->String{
        return self.location
    }
    
    func clear(){
        self.id = ""
        self.email = ""
        self.gender = ""
        self.website = ""
        self.name = ""
        self.location = ""
    }

    
    
    
}
