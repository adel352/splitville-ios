//
//  ViewController.swift
//  SplitVille
//
//  Created by Nabil Maadarani on 2016-02-27.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.customizeTextFields()
    }
    
    func customizeTextFields() {
        // Username
        self.usernameTextField.delegate = self
        
        // Keyboard toolbar
        let emailKeyboardToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 40))
        emailKeyboardToolbar.barStyle = UIBarStyle.Default
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneButtonAction")
        emailKeyboardToolbar.setItems([space, done], animated: false)
        emailKeyboardToolbar.sizeToFit()
        
        self.usernameTextField.inputAccessoryView = emailKeyboardToolbar
        
        // Password
        self.passwordTextField.delegate = self
        self.passwordTextField.inputAccessoryView = emailKeyboardToolbar
    }
    
    func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    // Keyboard Go button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            textField.resignFirstResponder()
            logInButtonPressed(self)
        }
        
        return true
    }
    
    @IBAction func logInButtonPressed(sender: AnyObject) {
        self.loadingIndicator.startAnimating()
        delay(2) {
            self.loadingIndicator.stopAnimating()
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CameraViewController") as! CameraViewController
            self.presentViewController(nextViewController, animated: true, completion: nil)
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}

