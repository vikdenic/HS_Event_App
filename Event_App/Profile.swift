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
    @NSManaged var name : String!
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

    @NSManaged var coverPhotoFile : PFFile!
    var coverPhoto : UIImage! {
        get
        {
            return UIImage(data: coverPhotoFile.getData(nil))
        }
        set
        {
            coverPhotoFile = PFFile(data: UIImagePNGRepresentation(coverPhoto))
        }
    }

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

    class func queryForCurrentUsersProfile(completed:(profile : Profile!, error : NSError!) -> Void)
    {
        let query = Profile.query()
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.includeKey("user")
        query.getFirstObjectInBackgroundWithBlock { (theProfile, error) -> Void in
            if error != nil
            {
                completed(profile: nil, error: error)
            }
            else
            {
                completed(profile: theProfile as Profile!, error: nil)
            }
        }
    }
}