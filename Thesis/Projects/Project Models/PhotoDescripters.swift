//
//  PhotoDescriptors.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/26/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import Foundation
import UIKit

class PhotoDescriptors {
	var imageName: String?
	var photoDescription: String?
	var id: String?
	
	init(imageName: String, photoDescription: String, id: String) {
		self.imageName = imageName
		self.photoDescription = photoDescription
		self.id = id
	}
}
