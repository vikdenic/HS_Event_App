//
//  EditProfileViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var hometownTextField: UITextField!
    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    let profile = UniversalProfile.sharedInstance.profile

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
    }

    override func viewWillAppear(animated: Bool) {
        setProfileData()
    }

    func setUpCamera()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }

    func setProfileData()
    {
        nameTextField.text = profile?.name
        hometownTextField.text = profile?.hometown
    }

    func saveProfileData()
    {
        profile?.name = nameTextField.text
        profile?.hometown = hometownTextField.text
        profile?.profilePicFile = PFFile(data: UIImagePNGRepresentation(selectedImage))
        profile?.saveInBackgroundWithBlock(nil)
    }

    @IBAction func onSelectPhotoTapped(sender: UIButton)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func onSaveButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.saveProfileData()
        })
    }

    @IBAction func onCancelButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = image
        })
    }
}
