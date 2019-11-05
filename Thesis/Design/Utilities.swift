//
//  Utilities.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/29/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//
import UIKit
import Foundation

class Utilities {
	static func stytleTextField(_ textfield:UITextField) {
		//-- Create the bottom line
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
		bottomLine.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
		
		//-- Remove the border on the text field
		textfield.borderStyle = .none
		
		//-- Add the line to the text field
		textfield.layer.addSublayer(bottomLine)
	}
	
	static func styleFilledBtn(_ button:UIButton) {
		//-- Filled rounded corner style
		button.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
		button.layer.cornerRadius = 15.0
		button.tintColor = UIColor.white
	}
}
