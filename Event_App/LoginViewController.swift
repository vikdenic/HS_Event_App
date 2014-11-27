//
//  LoginViewController.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidAppear(animated: Bool) {
        Profile.queryForCurrentUsersProfile { (profile, error) -> Void in
            self.imageView.image = profile.profilePic
        }
    }

    @IBAction func onLoginButtonTapped(sender: UIButton)
    {
        if usernameTextField.text == "" || passwordTextField.text == ""
        {
            showAlert("Please enter a username and password.", nil, self)
        }
        else
        {
            User.loginUser(usernameTextField.text, password: passwordTextField.text) { (result, error) -> Void in
                if error != nil
                {
                    showAlertWithError(error, self)
                }
                else
                {

                }
            }
        }
    }
}
