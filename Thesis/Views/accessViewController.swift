//
//  accessViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class accessViewController: UIViewController {
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var adminBtn: UIButton!
	
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		setUpElements()
	}
	
	func setUpElements() {
		Utilities.stytleTextField(emailTextField)
		Utilities.stytleTextField(passwordTextField)
		Utilities.styleFilledBtn(loginBtn)
		Utilities.styleFilledBtn(adminBtn)
	}
}
