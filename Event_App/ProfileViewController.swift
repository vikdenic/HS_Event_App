//
//  ProfileViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var photosArray = [Photo]()
    @IBOutlet var tableView: UITableView!

    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var coverPhotoImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        setProfileData()
        retrievePhotosData()
    }

    func setProfileData()
    {
        UniversalProfile.sharedInstance.profile?.profilePicFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
            self.profilePicImageView.image = UIImage(data: data)
        })

        UniversalProfile.sharedInstance.profile?.coverPhotoFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
            self.coverPhotoImageView.image = UIImage(data: data)
        })
    }

    func retrievePhotosData()
    {
        Photo.queryForPhotos { (photos, error) -> Void in
            for photo in photos
            {
                if photo.photographer.objectId == UniversalProfile.sharedInstance.profile?.objectId
                {
                    self.photosArray.append(photo)
                }
            }
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as ProfileTableViewCell
        let photo = photosArray[indexPath.row]
        photo.imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            cell.photoImageView.image = UIImage(data: data)
        }
        return cell
    }
}
