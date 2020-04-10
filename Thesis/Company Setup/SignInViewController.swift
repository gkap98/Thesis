//
//  SignInViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 4/7/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import UIGradient

class SignInViewController: UIViewController {
	
	// OUTLETS
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signInBtn: UIButton!
	@IBOutlet weak var signUpBtn: UIButton!
	@IBOutlet weak var back: UIView!
	@IBOutlet weak var error: UILabel!
	
	var gradientLayer: CAGradientLayer!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpElements()
		
        // Do any additional setup after loading the view.
    }
	@IBAction func signInTapped(_ sender: Any) {
		signIn(email: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
			if let error = error {
				self.error.text = error.localizedDescription
			} else {
				self.emailTextField.text = ""
				self.passwordTextField.text = ""
				self.error.text = ""
				self.performSegue(withIdentifier: "log", sender: nil)
			}
		}
	}
	
}
extension SignInViewController {
	func setUpElements() {
		createGradientLayer()
		error.text = ""
		DesignUtilities.styleUnderlinedTextField(emailTextField)
		DesignUtilities.styleUnderlinedTextField(passwordTextField)
		DesignUtilities.menuStylebutton(signInBtn)
	}
	func createGradientLayer() {
		gradientLayer = CAGradientLayer()
	 
		gradientLayer.frame = self.view.bounds
	 
		gradientLayer.colors = [DesignUtilities.Color.darkEnd.cgColor, DesignUtilities.Color.darkStart.cgColor]
	 
		self.back.layer.addSublayer(gradientLayer)
	}
	
	func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
		Auth.auth().signIn(withEmail: email, password: password, completion: handler)
	}
}
