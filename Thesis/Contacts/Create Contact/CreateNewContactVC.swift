//
//  CreateNewContactVC.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/24/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class CreateNewContactVC: UIViewController {
// OUTLETS
	@IBOutlet weak var firstName: UITextField!
	@IBOutlet weak var lastName: UITextField!
	@IBOutlet weak var phoneNumber: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var association: UITextField!
	@IBOutlet weak var addContactPhotoBtn: UIButton!
	@IBOutlet weak var contactPhoto: UIImageView!
	@IBOutlet weak var completeContactBtn: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		navigationController?.navigationBar.prefersLargeTitles = true
		setUpElements()
		overrideUserInterfaceStyle = .dark
		
    }
	// Show Camera and Pictures from Library
	var imagePicker: UIImagePickerController!
	var takenImage: UIImage!
	var imageDownloadURL: String?
	
	// MARK: - Button Actions
	
	@IBAction func addContactPhotoBtnTapped(_ sender: Any) {
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
	
	@IBAction func completeContactBtnTapped(_ unwindSegue: UIStoryboardSegue) {
		let contactRef = Database.database().reference().child("Contacts").childByAutoId()
		let newContactKey = contactRef.key!
		
		guard let image = contactPhoto.image, let data = image.jpegData(compressionQuality: 0.4) else {
			// Show error
			let alert = UIAlertController(title: "Error", message: "Something when wrong", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			return
		}
		let imageName = UUID().uuidString
		let imageReference = Storage.storage().reference().child("Contact Photos").child(imageName)
		
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
				
				// Create Data For Database
				let data = [
					"First Name" : self.firstName.text!,
					"Last Name" : self.lastName.text!,
					"Phone Number" : self.phoneNumber.text!,
					"Email" : self.email.text!,
					"Association" : self.association.text!,
					"Contact ID" : newContactKey,
					"Image URL" : urlString
				] as [String:Any]
				
				contactRef.setValue(data) { (error, ref) in
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
					
					UserDefaults.standard.set(newContactKey, forKey: "projectID")
					
					let alert = UIAlertController(title: "Success", message: "Please press the back button to see all Contacts ", preferredStyle: .alert)
					self.present(alert, animated: true)
					alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
					
				}
			}
		}
		
	}
}

// MARK: - Extension Functions
extension CreateNewContactVC {
	func setUpElements() {
		DesignUtilities.styleFilledBtn(addContactPhotoBtn)
		DesignUtilities.styleCircleImageWithBorder(contactPhoto)
		DesignUtilities.styleFilledBtn(completeContactBtn)
		
		DesignUtilities.styleUnderlinedTextField(firstName)
		DesignUtilities.styleUnderlinedTextField(lastName)
		DesignUtilities.styleUnderlinedTextField(phoneNumber)
		DesignUtilities.styleUnderlinedTextField(email)
		DesignUtilities.styleUnderlinedTextField(association)
	}
}

// MARK: - ImagePicker Functions
extension CreateNewContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			self.takenImage =  image
			self.contactPhoto.image = self.takenImage
		} else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			self.takenImage = image
			self.contactPhoto.image = self.takenImage
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		print("Image Picker Canceled")
		self.dismiss(animated: true, completion: nil)
	}
}
