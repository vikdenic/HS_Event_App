//
//  EventsViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/8/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var eventsArray = [Event]()
    @IBOutlet var tableView: UITableView!

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

    override func viewWillAppear(animated: Bool) {
        setEventData()
    }

    @IBAction func onRefreshButtonTapped(sender: UIBarButtonItem)
    {
        setEventData()
    }

    func setEventData()
    {
        Event.queryForEvents { (events, error) -> Void in
            self.eventsArray = events as [Event]
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as EventTableViewCell
        let event = eventsArray[indexPath.row] as Event!
        cell.eventNameLabel.text = event.title
        cell.eventDateLabel.text = event.date.toStringOfMonthDayAndTime()
        cell.eventImageView.image = event.eventPic
        cell.hostImageView.image = event.host.profilePic
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
}
