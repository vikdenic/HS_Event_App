//
//  ProfileViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var eventsArray = [Event]()
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func retrieveEventData()
    {
        Event.queryForEvents { (events, error) -> Void in
            self.eventsArray = events

        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as ProfileTableViewCell
        return cell
    }
}
