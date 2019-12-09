//
//  Project.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/5/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import Foundation
import UIKit

class Project {
	var title: String
	var address: String
	var image: UIImage
	
	init(titled: String, address: String, imageName: String) {
		self.title = titled
		self.address = address
		self.image = UIImage(named: imageName)!
	}
}
