//
//  EventsViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/8/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    var eventsArray = [Event]()
    @IBOutlet var tableView: UITableView!

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier("EventsToRegisterSegue", sender: self)
        }
        else
        {
            Profile.queryForCurrentUsersProfile({ (profile, error) -> Void in
                println("\(PFUser.currentUser().username) logged in")
                self.setEventData()
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        if PFUser.currentUser() != nil
        {
            setEventData()
        }
    }

    //MARK: Helper methods
    func setEventData()
    {
        Event.queryForEvents { (events, error) -> Void in
            self.eventsArray = events as [Event]
            self.tableView.reloadData()
        }
    }

    //MARK: Actions
    @IBAction func onRefreshButtonTapped(sender: UIBarButtonItem)
    {
        setEventData()
    }

    //MARK: UITableViewDelegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as EventTableViewCell
        let event = eventsArray[indexPath.row] as Event!
        cell.eventNameLabel.text = event.title
        cell.eventDateLabel.text = event.createdAt.toStringOfMonthDayAndTime()

        event.eventPicFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            cell.eventImageView.image = UIImage(data: data)
        }

        event.host.profilePicFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            cell.hostImageView.image = UIImage(data: data)
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }

    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "EventsToIndivSegue"
        {
            let indivEventVC = segue.destinationViewController as IndividualEventViewController
            indivEventVC.thisEvent = eventsArray[tableView.indexPathForSelectedRow()!.row]
        }
    }
}
