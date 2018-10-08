//
//  PhotoAnnotation.swift
//  PhotoMap
//
//  Created by Pat Khai on 10/6/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import MapKit

class PhotoAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var photo: UIImage!
    
    var title: String? {
        return "\(coordinate.latitude)"
    }
}
