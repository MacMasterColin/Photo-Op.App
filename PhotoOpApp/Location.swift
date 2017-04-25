//
//  Location.swift
//  PhotoOpApp
//
//  Created by Reagan W. Davenport on 4/18/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Location
{
    var name = String()
    var tags = [String]()
    var location = CLLocation()
    var image : UIImage?
    
    convenience init(name : String, tags : [String], location : CLLocation, image : UIImage?) {
        self.init()
        self.name = name
        self.tags = tags
        self.location = location
        self.image = image
    }
}
