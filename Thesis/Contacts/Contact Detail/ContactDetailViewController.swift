//
//  ContactDetailViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/24/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ContactDetailViewController: UIViewController {

	@IBOutlet weak var contactPhoto: UIImageView!
	@IBOutlet weak var contactName: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var phoneNum: UITextView!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var association: UILabel!
	@IBOutlet weak var editContactBtn: UIButton!
	var first: String!
	var last: String!
	
	@IBAction func refreshTapped(_ sender: Any) {
		viewDidLoad()
	}
	
	
	var selectedContactID: String?
	var contributorArray = [String]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
		getContactInfo()
		overrideUserInterfaceStyle = .dark
		setUpElements()
    }
}

// MARK: - Extension Functions
extension ContactDetailViewController {
	func getContactInfo() {
		let contactRef = Database.database().reference().child("Contacts").child(selectedContactID!)
		contactRef.observeSingleEvent(of: .value) { (snapshot) in
			let contactDict = snapshot.value as? NSDictionary
			let firstName = contactDict!["First Name"] as? String
			let lastName = contactDict!["Last Name"] as? String
			let phone = contactDict!["Phone Number"] as? String
			let email = contactDict!["Email"] as? String
			let association = contactDict!["Association"] as? String
			let id = contactDict!["Contact ID"] as? String
			let urlString = contactDict!["Image URL"] as? String
			
			let url = URL(string: urlString!)
			let resource = ImageResource(downloadURL: url!)
			self.contactPhoto.kf.setImage(with: resource, completionHandler: { (result) in
				switch result {
				case .success(_):
					print("Successfully gathered photo for contacts display")
				case .failure(let error):
					print(error.localizedDescription)
				}
			})
			self.first = firstName
			self.last = lastName
			let name = "\(firstName!) \(lastName!)"
			self.contactName.text = name
			self.phoneNum.text = phone
			self.email.text = email
			self.association.text = association
			
			if phone == nil {
				self.phoneNumber.text = "NA"
			}
			if email == nil {
				self.email.text = "NA"
			}
			if association == nil {
				self.association.text = "NA"
			}
			
		}
	}
	func setUpElements() {
		contactPhoto.layer.cornerRadius = 9
		contactName.layer.cornerRadius = 9
		contactName.layer.borderColor = DesignUtilities.getMasterColor()
		contactName.layer.borderWidth = 3
		DesignUtilities.menuStylebutton(editContactBtn)
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "editContact" {
			let editVC = segue.destination as! EditContactViewController
			editVC.first = first
			editVC.last = last
			editVC.phone = phoneNum.text
			editVC.email = email.text
			editVC.association = association.text
			editVC.id = selectedContactID
		}
	}
}
