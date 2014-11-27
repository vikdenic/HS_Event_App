//
//  RegisterViewController.swift
//  Event_App
//
//  Created by Vik Denic on 11/26/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import Foundation

class RegisterViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBAction func onRegisterButtonTapped(sender: UIButton)
    {
        if usernameTextField.text == "" || passwordTextField.text == ""
        {
            showAlert("Please enter a username and password.", nil, self)
        }
        else
        {
            User.registerNewUser(usernameTextField.text, password: passwordTextField.text) { (result, error) -> Void in
                if error != nil
                {
                    showAlertWithError(error, self)
                }
            }
        }
    }
}
