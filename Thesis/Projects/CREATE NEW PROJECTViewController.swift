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
		DesignUtilities.styleFilledBtn(addPhotoBtn)
		DesignUtilities.styleCircleImageWithBorder(projectImage)
		DesignUtilities.styleFilledBtn(completeProjectBtn)
		
		DesignUtilities.styleUnderlinedTextField(titleTextField)
		DesignUtilities.styleUnderlinedTextField(streetAddressTextField)
		DesignUtilities.styleUnderlinedTextField(cityTextField)
		DesignUtilities.styleUnderlinedTextField(stateTextField)
		DesignUtilities.styleUnderlinedTextField(zipTextField)
		DesignUtilities.styleUnderlinedTextField(totalCostTextField)
		DesignUtilities.styleUnderlinedTextField(startYearTextField)
		DesignUtilities.styleUnderlinedTextField(endYearTextField)
	}
	
	// Show Camera and Pictures from Library
	var imagePicker: UIImagePickerController!
	var takenImage: UIImage!
	@IBAction func addProjectImage(_ sender: Any) {
		imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			imagePicker.sourceType = .camera
			imagePicker.cameraCaptureMode = .photo
		} else {
			imagePicker.sourceType = .photoLibrary
		}
		self.present(imagePicker, animated: false, completion: nil)
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
				print("Error Handling Post")
			}
		})
	}
	
}


extension CREATE_NEW_PROJECTViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
		self.takenImage = image
		self.projectImage.image = self.takenImage
		self.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		self.dismiss(animated: true, completion: nil)
	}
}







