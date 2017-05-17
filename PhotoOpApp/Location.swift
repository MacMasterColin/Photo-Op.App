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
import RealmSwift
import Realm

class Location : Object
{
    dynamic var name = String()
    dynamic var tag = String()
    dynamic var latitude = Double()
    dynamic var longitude = Double()
    dynamic var city = String()
    dynamic var image = Data()
    
    convenience init(name : String, tag : String, latitude : Double, longitude : Double, image : Data) {
        self.init()
        self.name = name
        self.tag = tag
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
    }
}
