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

    class func queryForEvents(completed:(events : [Event!]!, error : NSError!) -> Void)
    {
        let query = Event.query()
        query.includeKey("host")
        query.findObjectsInBackgroundWithBlock { (events, error) -> Void in
            if error != nil
            {
                completed(events: nil, error: error)
            }
            else
            {
                completed(events: events as [Event!]!, error: nil)
            }
        }
    }
}