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

    
    func handleError(_ title: String, message: String, dismiss: String)
    {
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "\(dismiss)", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    //this function will get the session Key and make sure we log in after logging in we will get the account key so that we can get First and last name 
    func login (_ username : String, password: String, completionHandler: @escaping (_ success: Bool, _ errorString: String?) -> Void)
    {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                self.handleError("Error",message: "An error occured Please try again",dismiss: "Retry")
                return
            }
            
            let range = Range(uncheckedBounds: (5, data!.count - 5))
            
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
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
