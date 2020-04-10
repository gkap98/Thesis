//
//  EditContactViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 3/13/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class EditContactViewController: UIViewController {

	@IBOutlet weak var firstTextField: UITextField!
	@IBOutlet weak var lastTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var associationTextField: UITextField!
	@IBOutlet weak var finishEditingBtn: UIButton!
	
	var first: String?
	var last: String?
	var phone: String?
	var email: String?
	var association: String?
	var id: String?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
	@IBAction func finishBtnTapped(_ sender: Any) {
		let contactRef = Database.database().reference().child("Contacts").child(id!)
		contactRef.child("First Name").setValue(firstTextField.text)
		contactRef.child("Last Name").setValue(lastTextField.text)
		contactRef.child("Phone Number").setValue(phoneTextField.text)
		contactRef.child("Email").setValue(emailTextField.text)
		contactRef.child("Association").setValue(associationTextField.text)
		
		let alert = UIAlertController(title: "Successfully Edited \(first!)'s Contact", message: "Please press the back button to see your contact", preferredStyle: .alert)
		self.present(alert, animated: true)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
	}
}

extension EditContactViewController {
	func setUpElements() {
		DesignUtilities.styleUnderlinedTextField(firstTextField)
		firstTextField.text = first
		DesignUtilities.styleUnderlinedTextField(lastTextField)
		lastTextField.text = last
		DesignUtilities.styleUnderlinedTextField(phoneTextField)
		phoneTextField.text = phone
		DesignUtilities.styleUnderlinedTextField(emailTextField)
		emailTextField.text = email
		DesignUtilities.styleUnderlinedTextField(associationTextField)
		associationTextField.text = association
		DesignUtilities.menuStylebutton(finishEditingBtn)
	}
}
