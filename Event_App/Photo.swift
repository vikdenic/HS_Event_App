//
//  Photo.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

class Photo: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Photo"
    }

    @NSManaged var event : Event!
    @NSManaged var imageFile : PFFile!
    @NSManaged var likesCount : Int
    @NSManaged var photographer : Profile!

    class func queryForPhotos(completed:(photos : [Photo]!, error : NSError!) -> Void)
    {
        let query = Photo.query()
        query.includeKey("event")
        query.includeKey("photographer")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (photos, error) -> Void in
            if error != nil
            {
                completed(photos: nil, error: error)
            }
            else
            {
                completed(photos: photos as [Photo], error: nil)
            }
        }
    }
}