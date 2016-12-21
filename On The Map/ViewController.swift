//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ashutosh Kumar Sai on 20/12/16.
//  Copyright © 2016 Ashish Rajendra Kumar Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var statusText: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if let signupURL = URL(string: "https://auth.udacity.com/sign-up?next=https://in.udacity.com/")
        {
            UIApplication.shared.openURL(signupURL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

