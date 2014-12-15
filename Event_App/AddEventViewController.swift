//
//  AddEventViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/9/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: View lifecycle
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailsTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    var imagePicker = UIImagePickerController()
    var selectedImage = UIImage?()
    var location = CLLocation?()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
    }

    //MARK: Helper methods
    func setUpCamera()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }

    func createNewEvent()
    {
        let newEvent = Event()
        newEvent.host = kProfile
        newEvent.details = detailsTextField.text
        newEvent.title = titleTextField.text
        newEvent.eventPicFile = PFFile(data: UIImagePNGRepresentation(selectedImage))
        newEvent.location = PFGeoPoint(location: location)
        newEvent.saveInBackgroundWithBlock(nil)
    }

    //MARK: Reverse Geocoding
    func geocodeLocationWithBlock(located : (succeeded : Bool, error : NSError!) -> Void)
    {
        var geocode = CLGeocoder()
        geocode.geocodeAddressString(locationTextField.text, completionHandler: { (placemarks, error) -> Void in
            if error != nil
            {
                showAlertWithError(error, self)

            }
            else
            {
                let locations : [CLPlacemark]  = placemarks as [CLPlacemark]
                self.location = locations[0].location
                located(succeeded: true, error: error)
            }
        })
    }

    //MARK: Actions
    @IBAction func onSelectEventPhotoTapped(sender: UIButton)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func onDoneButtonTapped(sender: UIBarButtonItem)
    {
        if titleTextField.text == "" || detailsTextField.text == "" || locationTextField.text == "" || selectedImage == nil
        {
            showAlert("Please fill out all required forms", nil, self)
        }
        else
        {
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.geocodeLocationWithBlock({ (succeeded, error) -> Void in
                    self.createNewEvent()
                })
            })
        }
    }

    @IBAction func onCancelButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = image
        })
    }
}
