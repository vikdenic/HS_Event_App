//
//  Profile.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

class Profile: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Profile"
    }

    @NSManaged var user : User!
    @NSManaged var hometown : String!
    @NSManaged var bio : String!
    @NSManaged var profilePicFile : PFFile!
    var profilePic : UIImage! {
        get
        {
            return UIImage(data: profilePicFile.getData(nil))
        }
        set
        {
            profilePicFile = PFFile(data: UIImagePNGRepresentation(profilePic))
        }
    }

    @NSManaged var coverPhoto : String!

    class func createProfile(user : User!, completed:(profile: Profile!, succeeded: Bool!, error: NSError!) -> Void)
    {
        let newProfile = Profile()
        newProfile.user = user

        newProfile.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if error != nil
            {
                completed(profile: nil, succeeded: false, error: error)
            }
            else
            {
                completed(profile: newProfile, succeeded: true, error: error)
            }
        }
    }
}