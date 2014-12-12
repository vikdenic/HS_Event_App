//
//  UniversalProfile.swift
//  Event_App
//
//  Created by Vik Denic on 12/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

private let SharedProfile = UniversalProfile()

class UniversalProfile{

    class var sharedInstance : UniversalProfile
    {
        return SharedProfile
    }

    var profile = Profile?()
}
