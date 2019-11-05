//
//  projectTableView.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 11/5/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import Foundation
import UIKit

class ProjectTableView {
	
	var image: UIImage
	var title: String
	var address: String
	
	init(image: UIImage, title: String, address: String) {
		self.image = image
		self.title = title
		self.address = address
	}
}
