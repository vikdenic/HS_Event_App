//
//  AddEventViewController.swift
//  Event_App
//
//  Created by Vik Denic on 12/9/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailsTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onSelectEventPhotoTapped(sender: UIButton)
    {
        
    }

    @IBAction func onDoneButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }

    @IBAction func onCancelButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
