//
//  Contact.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/20/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import Foundation
import UIKit

class Contact {
	var firstName: String?
	var lastName: String?
	var phoneNumber: String?
	var association: String?
	var image: String?
	var id: String?
	
	init(first: String, last: String, number: String, association: String, image: String, id: String) {
		self.firstName = first
		self.lastName = last
		self.phoneNumber = number
		self.association = association
		self.image = image
		self.id = id
	}
}
