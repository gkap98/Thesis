//
//  adminViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/2/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class adminViewController: UIViewController {
	var gradientLayer: CAGradientLayer!
	
	@IBOutlet weak var changeEmailTextField: UITextField!
	@IBOutlet weak var changeEmailBtn: UIButton!
	@IBOutlet weak var changePasswordTextField: UITextField!
	@IBOutlet weak var changePasswordBtn: UIButton!
	@IBOutlet weak var back: UIView!
	
	//Color outlets
	@IBOutlet weak var yellowColorBtn: UIButton!
	@IBOutlet weak var babyBlueColorBtn: UIButton!
	@IBOutlet weak var oliveGreenColorBtn: UIButton!
	@IBOutlet weak var orangeRedColorBtn: UIButton!
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		overrideUserInterfaceStyle = .dark
		setUpElements()
    }
	func createGradientLayer() {
		gradientLayer = CAGradientLayer()
	 
		gradientLayer.frame = self.view.bounds
	 
		gradientLayer.colors = [DesignUtilities.Color.darkEnd.cgColor, DesignUtilities.Color.darkStart.cgColor]
	 
		self.back.layer.addSublayer(gradientLayer)
	}
    
	func setUpElements() {
		createGradientLayer()
		DesignUtilities.styleUnderlinedTextField(changeEmailTextField)
		DesignUtilities.styleFilledBtn(changeEmailBtn)
		
		DesignUtilities.styleUnderlinedTextField(changePasswordTextField)
		DesignUtilities.styleFilledBtn(changePasswordBtn)
		
		
		yellowColorBtn.layer.cornerRadius = 9
		babyBlueColorBtn.layer.cornerRadius = 9
		oliveGreenColorBtn.layer.cornerRadius = 9
		orangeRedColorBtn.layer.cornerRadius = 9
	}
	
	@IBAction func changeEmailTapped(_ sender: Any) {
		// Data Verification
		if changeEmailTextField.text == "" {
			let alert = UIAlertController(title: "Invalid Email", message: "Please Enter an Email Before Continuing", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			return
		}
		// Changing Email and Checking for Errors
		Auth.auth().currentUser?.updateEmail(to: changeEmailTextField.text!, completion: { (error) in
			if error != nil {
				let alert = UIAlertController(title: "Error Changing Email", message: "Please try again. If the problem persists please close the application and try again. ", preferredStyle: .alert)
				self.present(alert, animated: true)
				alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
				print("Error Changing Email")
				return
			} else {
				let alert = UIAlertController(title: "Email Change", message: "Email Succesfully Changed", preferredStyle: .alert)
				self.present(alert, animated: true)
				alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
				self.changeEmailTextField.text = nil
			}
		})
	}
	
	@IBAction func changePasswordTapped(_ sender: Any) {
		// Data Verification
		if changePasswordTextField.text == "" {
			let alert = UIAlertController(title: "Invalid Password", message: "Please Enter an Password Before Continuing", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			return
		}
		// Changing Password and Checking for Errors
		Auth.auth().currentUser?.updatePassword(to: changePasswordTextField.text!, completion: { (error) in
			if error != nil {
				let alert = UIAlertController(title: "Error Changing Password", message: "Please try again. If the problem persists please close the application and try again. ", preferredStyle: .alert)
				self.present(alert, animated: true)
				alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
				print("Error Changing Password")
				return
			} else {
				let alert = UIAlertController(title: "Password Change", message: "Password Succesfully Changed", preferredStyle: .alert)
				self.present(alert, animated: true)
				alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
				self.changePasswordTextField.text = nil
			}
		})
	}
	
	let colorRef = Database.database().reference().child("Color").child("Master Color")

	@IBAction func yellowColorBtnTapped(_ sender: Any) {
		colorRef.setValue("Yellow")

		let alert = UIAlertController(title: "Color Change Recognized", message: "Changing the Color scheme requires a restart of the app for color change to apear", preferredStyle: .alert)
		self.present(alert, animated: true)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
	}
	
	@IBAction func babyBlueColorBtnTapped(_ sender: Any) {
		colorRef.setValue("Blue")
		let alert = UIAlertController(title: "Color Change Recognized", message: "Changing the Color scheme requires a restart of the app for color change to apear", preferredStyle: .alert)
		self.present(alert, animated: true)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
	}
	@IBAction func oliveGreenColorBtnTapped(_ sender: Any) {
		colorRef.setValue("Green")
		let alert = UIAlertController(title: "Color Change Recognized", message: "Changing the Color scheme requires a restart of the app for color change to apear", preferredStyle: .alert)
		self.present(alert, animated: true)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
	}
	@IBAction func orangeRedColorBtnTapped(_ sender: Any) {
		colorRef.setValue("Red")

		let alert = UIAlertController(title: "Color Change Recognized", message: "Changing the Color scheme requires a restart of the app for color change to apear", preferredStyle: .alert)
		self.present(alert, animated: true)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
	}
}
