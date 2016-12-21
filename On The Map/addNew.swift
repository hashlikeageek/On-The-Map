//
//  addNew.swift
//  On The Map
//
//  Created by Ashutosh Kumar Sai on 21/12/16.
//  Copyright © 2016 Ashish Rajendra Kumar Sai. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class addNew : UIViewController, MKMapViewDelegate,UITextFieldDelegate
{
    @IBOutlet weak var link: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var findlocButton: UIButton!

       var submitThisCord = CLLocationCoordinate2D()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isHidden = true
        submit.isHidden = true
        status.isHidden = true
        self.link.delegate = self
        self.location.delegate = self
    }
    
    func errorHandler(_ errorMessage: String)
    {
        status.text = errorMessage
    }
    
    @IBAction func findlocationAction(_ sender: Any) {
        determineLocation()
    }
  
    
    
    func determineLocation()
    {
        
        status.isHidden = false
        if location.text == "" {
            errorHandler("Please Enter a valid location")
        }
        else
        {
            let maploc = location.text
            let encoder: CLGeocoder = CLGeocoder()
            
            encoder.geocodeAddressString(maploc!, completionHandler: { (clcplacemark, error) in
                
                if error == nil{
                    let placeamrk: CLPlacemark = clcplacemark![0]
                    let mapcord: CLLocationCoordinate2D = placeamrk.location!.coordinate
                    let pAnnotation: MKPointAnnotation = MKPointAnnotation()
                    pAnnotation.coordinate = mapcord
                    
                    // now we have to enable map so that user can see it 
                    self.mapView.isHidden = false
                    self.mapView?.addAnnotation(pAnnotation)
                    self.mapView?.centerCoordinate = mapcord
                    self.submitThisCord = mapcord
                    
                    self.location.isHidden = true
                    self.findlocButton.isHidden = true
                    self.submit.isHidden = false
                    self.status.isHidden = true
                
                    
                    
                }
                else
                {
                    self.errorHandler("Unable to fetch location")
                }
            })
            
        }
        
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        location.isHidden = true
        submit.isHidden = true
        status.isHidden = false
        findlocButton.isHidden = true
        parseClient.sharedInstance().submitData(submitThisCord.latitude.description, longitude: submitThisCord.longitude.description, addressField: location.text!, link: link.text!){
            (sucess, error)
            in
            if sucess {
                parseClient.sharedInstance().getData({ (sucess,title, message, dismiss ) in
                    if sucess
                    {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "tabNav")
                        self.present(controller!, animated: true, completion: nil)
                    }
                    else
                    {
                        self.errorHandler("Couldn't update View")
                    }
                })
            }
            else
            {
                self.errorHandler("Could Not post data , try again")
                self.submit.isHidden = false
            }
        
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        link.resignFirstResponder()
        location.resignFirstResponder()
        return false
    }

    
}
