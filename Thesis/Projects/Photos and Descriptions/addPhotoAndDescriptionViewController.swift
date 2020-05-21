//
//  addPhotoAndDescriptionViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/26/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class addPhotoAndDescriptionViewController: UIViewController {

	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var addPhotoButton: UIButton!
	@IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var completeBtn: UIButton!
	
	var projectID: String?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		DesignUtilities.menuStylebutton(addPhotoButton)
		DesignUtilities.menuStylebutton(completeBtn)
		navigationController?.navigationBar.prefersLargeTitles = false
		photo.layer.cornerRadius = 9.0
//		photo.layer.borderWidth = 2.0
//		photo.layer.borderColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
//		descriptionTextField.layer.borderColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
//		descriptionTextField.layer.borderWidth = 2.0
		overrideUserInterfaceStyle = .dark
    }

	
	// MARK: - Add Photo Button Tapped
	var imagePicker: UIImagePickerController!
	var takenImage: UIImage!
	var imageDownloadURL: String!
	@IBAction func addPhotoTapped(_ sender: Any) {
		imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			imagePicker.sourceType = .camera
			imagePicker.cameraCaptureMode = .photo
			imagePicker.isEditing = true
			imagePicker.allowsEditing = true
		} else {
			imagePicker.sourceType = .photoLibrary
			imagePicker.allowsEditing = true
		}
		self.present(imagePicker, animated: false, completion: nil)
	}
	// MARK: - Complete Button Tapped
	@IBAction func completeBtnTapped(_ sender: Any) {
		let databaseRef = Database.database().reference().child("Projects").child(projectID!).child("Photos").childByAutoId()
		let newPhotoKey = databaseRef.key!
		
		guard let image = photo.image, let data = image.jpegData(compressionQuality: 0.4) else {
			// Show Error
			 let alert = UIAlertController(title: "Error", message: "Something when wrong", preferredStyle: .alert)
			 self.present(alert, animated: true)
			 alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
			 return
		}
		let imageName = UUID().uuidString
		let imageRefernce = Storage.storage().reference().child("Project Images").child(imageName)
		
		imageRefernce.putData(data, metadata: nil) { (metadata, error) in
			if let error = error {
				// Show Alert
				let alert = UIAlertController(title: "Error", message: "Something went wrong adding image to firebase", preferredStyle: .alert)
				self.present(alert, animated: true)
				alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
				// Show error in console log
				print("Error Loading image data to firebase")
				print(error.localizedDescription)
				return
			}
			imageRefernce.downloadURL { (url, error) in
				if let error = error {
					// Show Alert
					let alert = UIAlertController(title: "Error", message: "Something went wrong adding image to firebase", preferredStyle: .alert)
					self.present(alert, animated: true)
					alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
					// Show error in console log
					print("Error Loading image data to firebase")
					print(error.localizedDescription)
					return
				}
				guard let url = url else {
					print("Something went wrong")
					return
				}
				
				let urlString = url.absoluteString
				
				// Create Data for Database
				let data = [
					"imageURL" : urlString,
					"description" : self.descriptionTextField.text!,
					"id" : databaseRef.key
				]
				
				databaseRef.setValue(data) { (error, ref) in
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
					
					UserDefaults.standard.set(newPhotoKey, forKey: "photoID")
					let alert = UIAlertController(title: "Success", message: "Please press the back button to see all photos ", preferredStyle: .alert)
					self.present(alert, animated: true)
					alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
					
				}
			}
		}
		
	}
	
}

extension addPhotoAndDescriptionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			self.takenImage = image
			self.photo.image = self.takenImage
		}
		if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			self.takenImage = image
			self.photo.image = self.takenImage
		}
		self.dismiss(animated: true, completion: nil)
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		self.dismiss(animated: true, completion: nil)
	}
}

extension addPhotoAndDescriptionViewController {
	func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
}
