//
//  ContactsViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/20/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

// MARK: - View Controller Class
class ContactsViewController: UIViewController {

	@IBOutlet weak var contactTableView: UITableView!
	@IBOutlet weak var refreshBtn: UIBarButtonItem!
	@IBOutlet weak var addBtn: UIButton!
	@IBOutlet weak var searchBar: UISearchBar!
	
	@IBAction func refreshedBtnTapped(_ sender: Any) {
		contactsArray = []
		searchedContactsArray = []
		getContactsFromDatabase()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		contactTableView.dataSource = self
		contactTableView.delegate = self
        // Do any additional setup after loading the view.
		navigationController?.navigationBar.prefersLargeTitles = true
		DesignUtilities.styleFloatingActionBtn(addBtn)
		overrideUserInterfaceStyle = .dark
		getContactsFromDatabase()
		setUpSearchBar()
    }
	var contactsArray = [Contact]()
	var searchedContactsArray = [Contact]()
	var selectedContact: Contact?
	
}
// MARK: - Table View Extension
extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchedContactsArray.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 110
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactsCell
		
		DesignUtilities.styleCircleImageWithBorder(cell.contactImage!)
		cell.contactImage.layer.borderColor = DesignUtilities.getMasterColor()
		// Configure Cell
		cell.first.text = self.searchedContactsArray[indexPath.row].firstName
		cell.last.text = self.searchedContactsArray[indexPath.row].lastName
		cell.contactAssosiation?.text = self.searchedContactsArray[indexPath.row].association
		
		let url = URL(string: self.searchedContactsArray[indexPath.row].image!)
		let resource = ImageResource(downloadURL: url!)
		cell.contactImage?.kf.setImage(with: resource, completionHandler: { (result) in
			switch result {
			case .success(_):
				print("Successfully gathered Contacts from Firebase Storage")
			case .failure(let error):
				print("Error Gathering Contacts: ")
				print(error.localizedDescription)
			}
		})
		return cell
	}
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		let ref = Database.database().reference().child("Contacts")
		let storageRef = Storage.storage().reference().child("Contact Photos").child(searchedContactsArray[indexPath.row].image!)
		if editingStyle == .delete {
			ref.child(searchedContactsArray[indexPath.row].id!).removeValue { (error, reference) in
				if error != nil {
					print("Error Deleting Contact From Database: \(error!)")
				} else {
					storageRef.delete { (error) in
						if error != nil {
							print("Error Deleting Photo Storage File \(error!)")
						}
					}
					self.searchedContactsArray.remove(at: indexPath.row)
					self.contactsArray.remove(at: indexPath.row)
					self.contactTableView.deleteRows(at: [indexPath], with: .automatic)
				}
			}
		}
	}
}

// MARK: - Extension Functions
extension ContactsViewController {
	func getContactsFromDatabase() {
		self.contactsArray = []
		let contactsRef = Database.database().reference().child("Contacts")
		contactsRef.observeSingleEvent(of: .value) { (snapshot) in
			for snap in snapshot.children {
				let contactSnap = snap as! DataSnapshot
				let contactDict = contactSnap.value as! [String:AnyObject]
				let first = contactDict["First Name"] as! String
				let last = contactDict["Last Name"] as! String
				let phoneNumber = contactDict["Phone Number"] as! String
				let association = contactDict["Association"] as! String
				let urlString = contactDict["Image URL"] as! String
				let contactID = contactDict["Contact ID"] as! String
				
				self.contactsArray.append(Contact(first: first, last: last, number: phoneNumber, association: association, image: urlString, id: contactID))
				self.searchedContactsArray.append(Contact(first: first, last: last, number: phoneNumber, association: association, image: urlString, id: contactID))
			}
			self.contactTableView.reloadData()
		}
	}
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showContact" {
			let contactDetailTVC = segue.destination as! ContactDetailViewController
			contactDetailTVC.selectedContactID = selectedContact?.id
		}
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let contact = contactsArray[indexPath.row]
		selectedContact = contact
		performSegue(withIdentifier: "showContact", sender: nil)
	}
}

// MARK: - Search Bar Extensions
extension ContactsViewController: UISearchBarDelegate {
	func setUpSearchBar() {
		searchBar.delegate = self
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard !searchText.isEmpty else {
			searchedContactsArray = contactsArray
			searchBar.showsCancelButton = false
			contactTableView.reloadData()
			return
		}
		searchBar.showsCancelButton = true
		searchedContactsArray = contactsArray.filter({ contact -> Bool in
			(
				(contact.firstName?.lowercased().contains(searchText.lowercased()))! 	||
				(contact.lastName?.lowercased().contains(searchText.lowercased()))! 	||
				(contact.association?.lowercased().contains(searchText.lowercased()))! 	||
				(contact.phoneNumber?.lowercased().contains(searchText.lowercased()))!
			)
			
		})
		contactTableView.reloadData()
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchedContactsArray = contactsArray
		searchBar.text = ""
		searchBar.showsCancelButton = false
		contactTableView.reloadData()
	}
}
