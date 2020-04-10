//
//  AddCharVC.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/14/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class AddCharVC: UIViewController {
	
	var projectID: String!

	@IBOutlet weak var keyTextField: UITextField!
	@IBOutlet weak var valueTextField: UITextField!
	@IBOutlet weak var addPairBtn: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		DesignUtilities.menuStylebutton(addPairBtn)
		DesignUtilities.styleUnderlinedTextField(keyTextField)
		overrideUserInterfaceStyle = .dark
		DesignUtilities.styleUnderlinedTextField(valueTextField)
	}
	@IBAction func addCharBtnTapped(_ sender: Any) {
		if keyTextField.text != " " || keyTextField.text != "" && valueTextField.text != " " || valueTextField.text != "" {
			addCharacteristic()
			let alert = UIAlertController(title: "Success", message: "Key : Value Pair Added to Database Under Project: \(projectID ?? "ID Not Found, Please check with database manager for assistance")", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
		} else {
			let alert = UIAlertController(title: "Error", message: "Please Ensure Keys and Values are not blank", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			return
		}
	}
	
}

extension AddCharVC {
	func addCharacteristic() {
		let projectRef = Database.database().reference().child("Projects").child(projectID!)
		projectRef.child("\(keyTextField.text!)").setValue(valueTextField.text!)
	}
}
