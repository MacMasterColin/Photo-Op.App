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
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: center, span: span)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = self.location.name
        self.MapView.addAnnotation(pin)
        self.MapView.setRegion(region, animated: true)
    }
}
