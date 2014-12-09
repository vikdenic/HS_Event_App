//
//  MMExtensions.swift
//  Event_App
//
//  Created by Vik Denic on 12/9/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

extension NSDate {
    /// :returns: a String object representation of the NSDate object's Month, Day and Time (i.e. December 2, 1990, 12:00AM)
    func toStringOfMonthDayAndTime() -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm aa"
        return dateFormatter.stringFromDate(self)
    }

    func toStringOfAbbrevMonthDayAndTime() -> String
    {
        //convert to regular looking time
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm aa"
        return dateFormatter.stringFromDate(self)
    }
}