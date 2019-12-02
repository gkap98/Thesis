//
//  accessViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import FirebaseUI

class accessViewController: UIViewController {
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var welcomeBtn: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setUpElements()
		
	}
	
	func setUpElements() {
		Utilities.styleFilledBtn(loginBtn)
		Utilities.styleFilledBtn(welcomeBtn)
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
		loginBtn.alpha = 0
		welcomeBtn.alpha = 1
	}
}

extension accessViewController: FUIAuthDelegate {
	func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
		// Check if there was an error
		if error != nil {
			// Log the error
			print("Error Logging In")
			return
		}
		print("Login Sucessful")
		//authDataResult?.user.uid
		
	}
}
