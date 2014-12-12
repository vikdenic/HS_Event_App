//
//  Event.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

class Event: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Event"
    }

    @NSManaged var title : String!
    @NSManaged var details : String!
    @NSManaged var date : NSDate!
    @NSManaged var host : Profile!

    @NSManaged var eventPicFile : PFFile!
    var eventPic : UIImage! {
        get
        {
            return UIImage(data: eventPicFile.getData(nil))
        }
        set
        {
            eventPicFile = PFFile(data: UIImagePNGRepresentation(eventPic))
        }
    }

    @NSManaged var locationGeoPoint : PFGeoPoint!
    var location : CLLocation! {
        get
        {
            return CLLocation(latitude: locationGeoPoint.longitude, longitude: locationGeoPoint.latitude)
        }
        set
        {
            locationGeoPoint = PFGeoPoint(location: location)
        }
    }

    class func queryForEvents(completed:(events : [Event]!, error : NSError!) -> Void)
    {
        let query = Event.query()
        query.includeKey("host")
        query.orderByDescending("date")
        query.findObjectsInBackgroundWithBlock { (events, error) -> Void in
            if error != nil
            {
                completed(events: nil, error: error)
            }
            else
            {
                completed(events: events as [Event], error: nil)
            }
        }
    }
}