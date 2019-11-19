//
//  CREATE NEW PROJECTViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 11/7/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Foundation
import Firebase


class CREATE_NEW_PROJECTViewController: UIViewController {
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var streetAddressTextField: UITextField!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var stateTextField: UITextField!
	@IBOutlet weak var zipTextField: UITextField!
	@IBOutlet weak var addPhotoBtn: UIButton!
	@IBOutlet weak var projectImage: UIImageView!
	@IBOutlet weak var totalCostTextField: UITextField!
	@IBOutlet weak var completeProjectBtn: UIButton!
	@IBOutlet weak var startYearTextField: UITextField!
	@IBOutlet weak var endYearTextField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
    
	func setUpElements() {
		Utilities.styleFilledBtn(addPhotoBtn)
		Utilities.styleCircleImageWithBorder(projectImage)
		Utilities.styleFilledBtn(completeProjectBtn)
	}
	
	@IBAction func addProjectImage(_ sender: Any) {
		projectImage.alpha = 1
	}
	@IBAction func completeProjectBtn(_ sender: Any) {
		
		// Firebase Code goes here
		let projectRef = Database.database().reference().child("Projects").childByAutoId()
		
		let projectObject = [
			"title" : titleTextField.text!,
			"streetAddrs" : streetAddressTextField.text!,
			"city" : cityTextField.text!,
			"state" : stateTextField.text!,
			"zip" : zipTextField.text!,
			"totalCost" : totalCostTextField.text!,
			"start" : startYearTextField.text!,
			"end" : endYearTextField.text!
		] as [String:Any]
		
		projectRef.setValue(projectObject, withCompletionBlock: { error, ref in
			if error == nil {
				self.dismiss(animated: true, completion: nil)
			} else {
				// HANDLE POST ERROR
			}
		})
	}
	
}
