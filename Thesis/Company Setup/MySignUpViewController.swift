//
//  MySignUpViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 4/7/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import UIGradient

class MySignUpViewController: UIViewController {

	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var signUpBtn: UIButton!
	@IBOutlet weak var error: UILabel!
	@IBOutlet weak var back: UIView!
	
	var gradientLayer: CAGradientLayer!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setupElements()
    }
	
	@IBAction func signUpTapped(_ sender: Any) {
		signUp(email: email.text!, password: password.text!) { (result, error) in
			if let error = error {
				self.error.text = error.localizedDescription
			} else {
				self.email.text = ""
				self.password.text = ""
				self.error.text = ""
				
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
	
    
}
extension MySignUpViewController {
	func setupElements() {
		createGradientLayer()
		DesignUtilities.styleUnderlinedTextField(email)
		DesignUtilities.styleUnderlinedTextField(password)
		DesignUtilities.menuStylebutton(signUpBtn)
		self.error.text = ""
	}
	func createGradientLayer() {
		gradientLayer = CAGradientLayer()
		
		gradientLayer.frame = self.view.bounds
		gradientLayer.colors = [DesignUtilities.Color.darkEnd.cgColor, DesignUtilities.Color.darkStart.cgColor]
		self.back.layer.addSublayer(gradientLayer)
	}
	func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
		Auth.auth().createUser(withEmail: email, password: password, completion: handler)
	}
}
