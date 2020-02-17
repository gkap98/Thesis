//
//  CREATE NEW PROJECTViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 11/7/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class CREATE_NEW_PROJECTViewController: UIViewController {
	
	// MARK: - Outlets and Variables
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
		navigationController?.navigationBar.prefersLargeTitles = false
    }
	// Show Camera and Pictures from Library
	var imagePicker: UIImagePickerController!
	var takenImage: UIImage!
	var imageDownloadURL: String?
	
	// MARK: - Button Actions
	@IBAction func addProjectImage(_ sender: Any) {
		imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			imagePicker.sourceType = .camera
			imagePicker.cameraCaptureMode = .photo
			imagePicker.allowsEditing = true
		} else {
			imagePicker.sourceType = .photoLibrary
			imagePicker.allowsEditing = true
		}
		self.present(imagePicker, animated: false, completion: nil)
	}
	@IBAction func completeProjectBtn(_ sender: Any) {
		// 1.0 - Firebase Database references Code goes here
		let projectRef = Database.database().reference().child("Projects").childByAutoId()
		let newProjectKey = projectRef.key!			// Key allows us to use as a reference in the storage
		
		// 2.0 - Convert the image from UIImage to JPEG data
		// Create data from image
		guard let image = projectImage.image, let data = image.jpegData(compressionQuality: 0.4) else {
			// Show error
			let alert = UIAlertController(title: "Error", message: "Something when wrong", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			return
		}
		let imageName = UUID().uuidString
		let imageReference = Storage.storage().reference().child("Images").child(imageName)
		
		imageReference.putData(data, metadata: nil) { (metadata, error) in
			if let error = error {
				// Show error in application
				let alert = UIAlertController(title: "Error", message: "Something went wrong adding image to firebase", preferredStyle: .alert)
				self.present(alert, animated: true)
				alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
				// Show error in console log
				print("Error Loading image data to firebase")
				print(error.localizedDescription)
				return
			}
			imageReference.downloadURL { (url, error) in
				if let error = error {
					// Show error in application
					let alert = UIAlertController(title: "Error", message: "Something went wrong adding image to firebase", preferredStyle: .alert)
					self.present(alert, animated: true)
					alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
					// Show error in console log
					print("Error Loading image data to firebase")
					print(error.localizedDescription)
					return
				}
				guard let url = url else {
					print("Something went wrong getting url")
					return
				}
				
				let urlString = url.absoluteString
				
				// Create Data for database
				let data = [
					"Title" : self.titleTextField.text!,
					"Street Address" : self.streetAddressTextField.text!,
					"City" : self.cityTextField.text!,
					"State" : self.stateTextField.text!,
					"Zip" : self.zipTextField.text!,
					"Total Cost" : self.totalCostTextField.text!,
					"Start Date" : self.startYearTextField.text!,
					"End Date" : self.endYearTextField.text!,
					"Project ID" : newProjectKey,
					"Image URL" : urlString
				] as [String:Any]
				
				projectRef.setValue(data) { (error, ref) in
					if let error = error {
						// Show error in application
						let alert = UIAlertController(title: "Error", message: "Something went wrong adding Data to Database", preferredStyle: .alert)
						self.present(alert, animated: true)
						alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
						// Show error in console log
						print("Error Loading data to firebase")
						print(error.localizedDescription)
						return
					}
					
					UserDefaults.standard.set(newProjectKey, forKey: "projectID")
					
					let alert = UIAlertController(title: "Success", message: "Please press the back button to see all projects ", preferredStyle: .alert)
					self.present(alert, animated: true)
					alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
					
				}
			}
		}
	}
}

extension CREATE_NEW_PROJECTViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			self.takenImage =  image
			self.projectImage.image = self.takenImage
		} else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			self.takenImage = image
			self.projectImage.image = self.takenImage
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		print("Image Picker Canceled")
		self.dismiss(animated: true, completion: nil)
	}
}

// MARK: - Extension Functions
extension CREATE_NEW_PROJECTViewController {
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
}



