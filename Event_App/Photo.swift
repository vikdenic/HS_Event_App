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

    ///The event that the photo was taken at
    @NSManaged var event : Event!
    ///The file of the photo's image (must be converted to UIImage for displaying)
    @NSManaged var imageFile : PFFile!
    ///The profile correlating to the photographer of the image
    @NSManaged var photographer : Profile!
    
    ///Creates a new user
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