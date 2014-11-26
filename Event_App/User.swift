//
//  User.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

class User: PFUser, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    ///Creates new user
    class func registerNewUser(username : String!, password : String!, completed:(result : Bool, error : NSError!) -> Void)
    {
        let newUser = User()
        newUser.username = username.lowercaseString
        newUser.password = password.lowercaseString

        newUser.signUpInBackgroundWithBlock { (succeeded, theError) -> Void in

            if theError != nil
            {
                completed(result: false, error: theError)
            }
            else
            {
                completed(result: true, error: nil)
            }
        }
    }
}