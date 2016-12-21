//
//  tabViewController.swift
//  On The Map
//
//  Created by Ashutosh Kumar Sai on 22/12/16.
//  Copyright © 2016 Ashish Rajendra Kumar Sai. All rights reserved.
//

import Foundation
import UIKit

class tabViewController : UITabBarController
{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        parseClient.sharedInstance().getData({ (sucess,title, message, dismiss ) in
            if sucess
            {
                print("Did reload your data")
            }
            else
            {
                print("Couldnt reload the data")
            }
        })

    }
}
