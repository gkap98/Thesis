//
//  accessViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import FirebaseAuth
import UIGradient
import FirebaseUI

class accessViewController: UIViewController {
	
	var gradientLayer: CAGradientLayer!
	
	@IBOutlet weak var back: UIView!
	
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var welcomeBtn: UIButton!
	@IBOutlet weak var logoutBtn: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		setUpElements()
		overrideUserInterfaceStyle = .dark
	}
	
	override func viewWillAppear(_ animated: Bool) {
		createGradientLayer()
	}

	func createGradientLayer() {
		gradientLayer = CAGradientLayer()
	 
		gradientLayer.frame = self.view.bounds
	 
		gradientLayer.colors = [DesignUtilities.Color.darkEnd.cgColor, DesignUtilities.Color.darkStart.cgColor]
	 
		self.back.layer.addSublayer(gradientLayer)
	}
	
	func setUpElements() {
		
		DesignUtilities.menuStylebutton(loginBtn)
		DesignUtilities.menuStylebutton(welcomeBtn)
		DesignUtilities.menuStylebutton(logoutBtn)
		welcomeBtn.alpha = 0
		logoutBtn.alpha = 0
	}

	@IBAction func loginTapped(_ sender: Any) {
		// Get the default UserInterface from Firebase
		let authUI = FUIAuth.defaultAuthUI()
		guard authUI != nil else {
			print("Error Loading UI View Controller")
			return
		}
		// Set user as the delegate
		authUI?.delegate = self
		authUI?.providers = [FUIEmailAuth()]
		// Get referance to the auth UI view controller
		let authViewController = authUI!.authViewController()
		// Show the Firebase User Interface
		self.present(authViewController, animated: true, completion: nil)
		
	}
	
	@IBAction func logoutTapped(_ sender: Any) {
		do {
			try Auth.auth().signOut()
			loginBtn.alpha = 1
			logoutBtn.alpha = 0
			welcomeBtn.alpha = 0
		} catch {
			print(error)
		}
	}
}

extension accessViewController: FUIAuthDelegate {
	func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
		// Check if there was an error
		if error != nil {
			// Log the error
			print("Error Logging In")
			print(error!)
			let alert = UIAlertController(title: "Error Logging In", message: "Please make sure that you have a valid internet connection.", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			return
		}
		loginBtn.alpha = 0
		logoutBtn.alpha = 1
		welcomeBtn.alpha = 1
		print("Login Sucessful")
	}
}
