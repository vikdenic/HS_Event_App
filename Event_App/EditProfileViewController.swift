//
//  EditProfileViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var hometownTextField: UITextField!
    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage?()

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
    }

    override func viewWillAppear(animated: Bool) {
        setProfileData()
    }

    //MARK: Helper methods
    func setUpCamera()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }

    func setProfileData()
    {
        nameTextField.text = kProfile?.name
        hometownTextField.text = kProfile?.hometown
    }

    func saveProfileData()
    {
        kProfile?.name = nameTextField.text
        kProfile?.hometown = hometownTextField.text
        if selectedImage != nil
        {
            kProfile?.profilePicFile = PFFile(data: UIImagePNGRepresentation(selectedImage))
        }
        kProfile?.saveInBackgroundWithBlock(nil)
        
    }

    //MARK: Actions
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

    //UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = image
        })
    }
}
