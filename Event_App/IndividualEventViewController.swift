//
//  IndividualEventViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class IndividualEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var tableView: UITableView!
    let imagePicker = UIImagePickerController()
    var photosArray = [Photo]()
    var thisEvent = Event()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
    }

    override func viewWillAppear(animated: Bool) {
        setPhotosData()
    }

    func setPhotosData()
    {
        photosArray.removeAll(keepCapacity: false)

        Photo.queryForPhotos { (photos, error) -> Void in
            for photo in photos
            {
                if photo.event.objectId == self.thisEvent.objectId
                {
                    self.photosArray.append(photo)
                }
            }
            self.photosArray.reverse()
            self.tableView.reloadData()
        }
    }

    func setUpCamera()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            let newPhoto = Photo()
            newPhoto.imageFile = PFFile(data: UIImagePNGRepresentation(image))
            newPhoto.event = self.thisEvent
            newPhoto.photographer = UniversalProfile.sharedInstance.profile
            newPhoto.likesCount = 0
            newPhoto.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                self.setPhotosData()
            })
        })
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as IndividualEventTableViewCell
        let photo = photosArray[indexPath.row]

        cell.likesCountLabel.text = String(photo.likesCount)
        cell.dateLabel.text = photo.createdAt.toStringOfAbbrevMonthDayAndTime()
        photo.imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
            cell.photoImageView.image = UIImage(data: data)
        })

        photo.photographer.profilePicFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
            cell.photographerImageView.image = UIImage(data: data)
        })

        return cell
    }

    @IBAction func onAddButtonTapped(sender: UIBarButtonItem)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
}
