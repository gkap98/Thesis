//
//  Utilities.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/29/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//
import UIKit
import MapKit
import Foundation

class DesignUtilities {
	static func styleUnderlinedTextField(_ textfield:UITextField) {
		//-- Create the bottom line
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
		bottomLine.backgroundColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		
		//-- Remove the border on the text field
		textfield.borderStyle = .none
		
		//-- Add the line to the text field
		textfield.layer.addSublayer(bottomLine)
	}
	
	static func styleFilledBtn(_ button:UIButton) {
		//-- Filled rounded corner style
		button.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 0)
		button.layer.borderColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		button.layer.borderWidth = 2.0
		button.layer.cornerRadius = 9.0
		button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}
	
	static func menuStylebutton(_ button:UIButton) {
		//-- menu buttons
		button.backgroundColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		button.layer.borderWidth = 2
		button.layer.cornerRadius = 9.0
		button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	}
	
	static func addBorderAndShadowToUIView(_ view:UIView) {
		//-- Trim Image and Style
		view.layer.borderWidth = 3.0
		view.layer.borderColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		view.layer.masksToBounds = false
		view.layer.cornerRadius = 3.0
		view.clipsToBounds = true
		view.layer.shadowRadius = 10.0
	}
	static func styleCircleImageWithBorder(_ image:UIImageView) {
		//-- Trim Image and Style
		image.layer.borderWidth = 4
		image.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		image.layer.masksToBounds = false
		image.layer.cornerRadius = image.frame.height / 2
		image.clipsToBounds = true
		image.layer.shadowRadius = 10.0
	}
	
	static func styleLabel(_ label:UILabel) {
		//-- Trim Image and Style
		label.layer.borderWidth = 4
		label.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		label.layer.masksToBounds = false
		label.layer.cornerRadius = 15
		label.clipsToBounds = true
	}
	
	static func styleFloatingActionBtn(_ button:UIButton) {
		button.layer.cornerRadius = button.frame.height/2
		button.layer.backgroundColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		button.layer.shadowOpacity = 0.25
		button.layer.shadowRadius = 5
		button.layer.borderWidth = 1
		button.layer.shadowOffset = CGSize(width: 0, height: 10)
	}
}
