//
//  accessViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import FirebaseAuth
class accessViewController: UIViewController {
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var adminBtn: UIButton!
	
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setUpElements()
		
		Auth.auth().signIn(withEmail: "test@avenconstruction.com", password: "123456789") { [weak self] authResult, error in guard self != nil else {return}
		}
	}
	
	func setUpElements() {
		Utilities.stytleTextField(emailTextField)
		Utilities.stytleTextField(passwordTextField)
		Utilities.styleFilledBtn(loginBtn)
		Utilities.styleFilledBtn(adminBtn)
	}
}
