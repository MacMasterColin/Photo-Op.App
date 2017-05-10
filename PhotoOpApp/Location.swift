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
    dynamic var x = Double()
    dynamic var y = Double()
    dynamic var image = Data()
    
    convenience init(name : String, tag : String, x : Double, y : Double, image : Data) {
        self.init()
        self.name = name
        self.tag = tag
        self.x = x
        self.y = y
        self.image = image
    }
}
