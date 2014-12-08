//
//  EventsViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/8/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier("EventsToRegisterSegue", sender: self)
        }
        else
        {
            println("\(PFUser.currentUser().username) logged in")
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as UITableViewCell

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
