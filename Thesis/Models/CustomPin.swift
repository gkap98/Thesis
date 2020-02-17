//
//  CustomPin.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/22/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import Foundation
import MapKit

class customPin: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D
	var title: String?
	var subtitle: String?
	
	init(coordinate: CLLocationCoordinate2D, pinTitle: String, pinSubTitle: String) {
		self.title = pinTitle
		self.subtitle = pinTitle
		self.coordinate = coordinate
	}
}
