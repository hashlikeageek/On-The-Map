//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ashutosh Kumar Sai on 20/12/16.
//  Copyright © 2016 Ashish Rajendra Kumar Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var errorHandler: UILabel!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    func iAmGoingToHandleErrors (_ errorString : String)
    {
        errorHandler.text = errorString
        login.isEnabled = true
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if let signupURL = URL(string: "https://auth.udacity.com/sign-up?next=https://in.udacity.com/")
        {
            UIApplication.shared.openURL(signupURL)
        }
    }
    @IBAction func logInAction(_ sender: Any) {
        //lets check basic errors in entries
        login.isEnabled = false
        errorHandler.text = "Hold On"
        
        if userName.text == "" ,passWord.text == ""
        {
         iAmGoingToHandleErrors("Username & Password  can not be empty")
        }
        
        udacityClient.sharedInstance().login(userName.text!,password: passWord.text!){ (success, errorString)
            in
            print("i am in loginaction")
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
         self.userName.delegate = self
         self.passWord.delegate = self
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        passWord.resignFirstResponder()
        return false
    }
}

