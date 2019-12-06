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
	@IBOutlet weak var changeEmailTextField: UITextField!
	@IBOutlet weak var changeEmailBtn: UIButton!
	@IBOutlet weak var changePasswordTextField: UITextField!
	@IBOutlet weak var changePasswordBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
    
	func setUpElements() {
		DesignUtilities.styleUnderlinedTextField(changeEmailTextField)
		DesignUtilities.styleFilledBtn(changeEmailBtn)
		
		DesignUtilities.styleUnderlinedTextField(changePasswordTextField)
		DesignUtilities.styleFilledBtn(changePasswordBtn)
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
	
}
