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
import Firebase

class DesignUtilities {
	
	struct Color {
		static let offWhite = UIColor(red: 225/255, green: 225/255, blue: 235/255, alpha: 1)
		static let darkStart = UIColor(red: 50/255, green: 60/255, blue: 65/255, alpha: 1)
		static let darkEnd = UIColor(red: 25/255, green: 25/255, blue: 30/255, alpha: 1)
	}
	
	static func queryForMasterColor() -> String {
		return "Red"
	}

	static func getMasterColor() -> CGColor {
		var masterColor: CGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		let color = queryForMasterColor()
		if color == "Yellow" {
			masterColor = #colorLiteral(red: 1, green: 0.7960642895, blue: 0, alpha: 1)
		} else if color == "Blue" {
			masterColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
		} else if color == "Green" {
			masterColor = #colorLiteral(red: 0.202696979, green: 0.2672695816, blue: 0.09948841482, alpha: 1)
		} else if color == "Red" {
			masterColor = #colorLiteral(red: 1, green: 0.2078431373, blue: 0.05882352941, alpha: 1)
		}
		return masterColor
	}
	static func getTintColor() -> UIColor {
		var masterTint: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		let color =  queryForMasterColor()
		if color == "Yellow" {
			masterTint = #colorLiteral(red: 1, green: 0.7960642895, blue: 0, alpha: 1)
		} else if color == "Blue" {
			masterTint = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
		} else if color == "Green" {
			masterTint = #colorLiteral(red: 0.202696979, green: 0.2672695816, blue: 0.09948841482, alpha: 1)
		} else if color == "Red" {
			masterTint = #colorLiteral(red: 1, green: 0.2078431373, blue: 0.05882352941, alpha: 1)
		}
		return masterTint
	}
	
	static func styleUnderlinedTextField(_ textfield:UITextField) {
		//-- Create the bottom line
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
		bottomLine.backgroundColor = getMasterColor()
		
		//-- Remove the border on the text field
		textfield.borderStyle = .none
		
		//-- Add the line to the text field
		textfield.layer.addSublayer(bottomLine)
	}
	
	static func styleFilledBtn(_ button:UIButton) {
		//-- Filled rounded corner style
		button.backgroundColor = UIColor.fromGradientWithDirection(.topLeftToBottomRight, frame: button.frame, colors: [#colorLiteral(red: 1, green: 0.2078431373, blue: 0.05882352941, alpha: 1),#colorLiteral(red: 1, green: 0.3326185644, blue: 0.5128910542, alpha: 1)])
		button.layer.borderColor = getMasterColor()
		button.layer.borderWidth = 2.0
		button.layer.cornerRadius = 9.0
		button.tintColor = .white
	}
	
	static func menuStylebutton(_ button:UIButton) {
		//-- menu buttons
		button.backgroundColor = UIColor.fromGradientWithDirection(.topLeftToBottomRight, frame: button.frame, colors: [#colorLiteral(red: 1, green: 0.2078431373, blue: 0.05882352941, alpha: 1),#colorLiteral(red: 1, green: 0.3326185644, blue: 0.5128910542, alpha: 1)])
		button.layer.borderColor = getMasterColor()
		button.layer.borderWidth = 2
		button.layer.cornerRadius = 9.0
		button.tintColor = .white
	}
	
	static func addBorderAndShadowToUIView(_ view:UIView) {
		//-- Trim Image and Style
		view.layer.borderWidth = 3.0
		view.layer.borderColor = getMasterColor()
		view.layer.masksToBounds = false
		view.layer.cornerRadius = 3.0
		view.clipsToBounds = true
		view.layer.shadowRadius = 10.0
	}
	static func styleCircleImageWithBorder(_ image:UIImageView) {
		//-- Trim Image and Style
		image.layer.borderWidth = 4
		image.layer.borderColor = getMasterColor()
		image.layer.masksToBounds = false
		image.layer.cornerRadius = image.frame.height / 2
		image.clipsToBounds = true
		image.layer.shadowRadius = 10.0
	}
	
	static func styleLabel(_ label:UILabel) {
		//-- Trim Image and Style
		label.layer.borderWidth = 4
		label.layer.borderColor = getMasterColor()
		label.layer.masksToBounds = false
		label.layer.cornerRadius = 15
		label.clipsToBounds = true
	}
	
	static func styleFloatingActionBtn(_ button:UIButton) {
		button.layer.cornerRadius = button.frame.height/2
		button.backgroundColor = UIColor.fromGradientWithDirection(.topLeftToBottomRight, frame: button.frame, colors: [#colorLiteral(red: 1, green: 0.2078431373, blue: 0.05882352941, alpha: 1),#colorLiteral(red: 1, green: 0.3326185644, blue: 0.5128910542, alpha: 1)])
		button.layer.shadowOpacity = 0.25
		button.layer.shadowRadius = 5
		button.layer.borderWidth = 1
		button.layer.shadowOffset = CGSize(width: 0, height: 10)
	}
}
