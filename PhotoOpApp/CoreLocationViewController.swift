//
//  CoreLocationViewController.swift
//  PhotoOpApp
//
//  Created by cmacgregor on 4/24/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CoreLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var MapView: MKMapView!
    
    var location : Location!
    
    override func viewDidLoad()
    {
        let location = CLLocation(latitude: self.location.latitude, longitude: self.location.longitude)
    }
}
