//
//  welcomeViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/2/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import UIGradient

class welcomeViewController: UIViewController {
	@IBOutlet weak var welcomeBtn: UIButton!
	@IBOutlet weak var adminBtn: UIButton!
	@IBOutlet weak var back: UIView!
	@IBOutlet weak var logout: UIButton!
	
	var gradientLayer: CAGradientLayer!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
		
		overrideUserInterfaceStyle = .dark
    }
	
	func createGradientLayer() {
		gradientLayer = CAGradientLayer()
	 
		gradientLayer.frame = self.view.bounds
	 
		gradientLayer.colors = [DesignUtilities.Color.darkEnd.cgColor, DesignUtilities.Color.darkStart.cgColor]
	 
		self.back.layer.addSublayer(gradientLayer)
	}
    
	func setUpElements() {
		createGradientLayer()
		DesignUtilities.menuStylebutton(welcomeBtn)
		DesignUtilities.menuStylebutton(adminBtn)
	}

	@IBAction func logoutTapped(_ sender: Any) {
		signOut()
	}
	
	func signOut() {
		do {
			try Auth.auth().signOut()
		} catch { print("Error Signing in") }
	}
}
