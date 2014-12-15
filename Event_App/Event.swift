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

    ///The title of the event
    @NSManaged var title : String!
    ///Details about the event
    @NSManaged var details : String!
    ///The profile of the user who created the event
    @NSManaged var host : Profile!
    ///The Parse location object of where the event is taking place (must be converted to a CLLocation for further functionality)
    @NSManaged var location : PFGeoPoint!
    ///The file of the photo representing the event (must be converted to UIImage for displaying)
    @NSManaged var eventPicFile : PFFile!

    ///Queries for all events and returns them in the block callback as [Event]
    class func queryForEvents(completed:(events : [Event]!, error : NSError!) -> Void)
    {
        let query = Event.query()
        query.includeKey("host")
        query.orderByDescending("createdAt")
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