//
//  AlertManager.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

func showAlert(title : String!, message : String!, viewController : UIViewController)
{
    var alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
    viewController.presentViewController(alert, animated: true, completion: nil)
}

func showAlertWithError(error : NSError!, forVC : UIViewController)
{
    var errorDescription = error.localizedDescription

    switch error.code
    {
    case kPFErrorUsernameTaken:
        errorDescription = "Username unavailable."
    case kPFErrorObjectNotFound:
        errorDescription = "Incorrect password."
    case kPFErrorUsernameMissing:
        errorDescription = "Please enter a username."
    case kPFErrorUserPasswordMissing:
        errorDescription = "Please enter a password."
    default:
        break
    }

    let alert = UIAlertController(title: errorDescription, message: nil, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(okAction)
    forVC.presentViewController(alert, animated: true, completion: nil)
}