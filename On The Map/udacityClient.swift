//
//  udacityClient.swift
//  On The Map
//
//  Created by Ashutosh Kumar Sai on 21/12/16.
//  Copyright © 2016 Ashish Rajendra Kumar Sai. All rights reserved.
//

import Foundation
import UIKit

class udacityClient : UIViewController {

     var userKey: String? = nil

    //this function will get the session Key and make sure we log in after logging in we will get the account key so that we can get First and last name 
    func login (_ username : String, password: String, completionHandler: @escaping (_ success: Bool, _ _title: String,_ _message: String,_ dismiss: String) -> Void)
    {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                
                DispatchQueue.main.async()
                {
                    completionHandler(false,"Error","An error occured Please try again","Retry")
                    return
                }
               
            }
            
            let newData = data!.subdata(in: 5..<(data!.count))
            print(newData)
            
            let parsedData = (try! JSONSerialization.jsonObject(with: newData, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
                
                print(parsedData)
            
            if let accountData = parsedData["account"] as? [String: AnyObject]
            {
             if let keyData = accountData["key"] as? String
            {
                self.userKey = keyData
                 print(keyData)
            }
            }
                
            else
            {
                DispatchQueue.main.async(){
               completionHandler(false,"Invalid Credential","Username or Password is invalid. Please Try Again","Try Again")
            }
            }
           
            
        }
        task.resume()
    }
    
    class func sharedInstance() -> udacityClient {
        struct Singleton {
            static var sharedInstance = udacityClient()
        }
        return Singleton.sharedInstance
    }
    
  


    
}
