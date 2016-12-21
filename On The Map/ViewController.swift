//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ashutosh Kumar Sai on 20/12/16.
//  Copyright © 2016 Ashish Rajendra Kumar Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var errorHandler: UILabel!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    
    func iAmGoingToHandleErrors (_ errorString : String)
    {
        errorHandler.text = errorString
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if let signupURL = URL(string: "https://auth.udacity.com/sign-up?next=https://in.udacity.com/")
        {
            UIApplication.shared.openURL(signupURL)
        }
    }
    @IBAction func logInAction(_ sender: Any) {
        //lets check basic errors in entries
        if userName.text == "" ,passWord.text == ""
        {
         iAmGoingToHandleErrors("Username & Password  can not be empty")
        }
    //step 1 - fetch UserKey from Udacity 
        //if it goes through  than fetch student data 
            // call complete login method
        //otherwise return error
        
    }
    
    
    func completeLogin()
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "tempScreen")
        
        present(controller!, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

