//
//  helpViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/28/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class helpViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var pageTitle: UILabel!
	@IBOutlet weak var subheading: UILabel!
	@IBOutlet weak var viewLine: UIView!
	@IBOutlet weak var helpCollectionView: UICollectionView!
	
	var helpArray = [Help]()
	var searchedHelpArray = [Help]()
	var selectedHelp: Help?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		helpCollectionView.delegate = self
		helpCollectionView.dataSource = self
		navigationController?.navigationBar.prefersLargeTitles = false
		viewLine.backgroundColor = DesignUtilities.getTintColor()
		setUpSearchBar()
		getHelp()
    }
}

// MARK: - SearchBar Extension
extension helpViewController: UISearchBarDelegate {
	private func setUpSearchBar() {
		searchBar.delegate = self
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard !searchText.isEmpty else {
			searchedHelpArray = helpArray
			helpCollectionView.reloadData()
			searchBar.showsCancelButton = false
			return
		}
		searchBar.showsCancelButton = true
		searchedHelpArray = helpArray.filter({ help -> Bool in
			(
				(help.title?.lowercased().contains(searchText.lowercased()))!
			)
		})
		helpCollectionView.reloadData()
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchedHelpArray = helpArray
		searchBar.text = ""
		searchBar.showsCancelButton = false
		helpCollectionView.reloadData()
	}
}

// MARK: - Collection View
struct Help {
	var title: String!
	var helpDescription: String!
}
extension helpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.searchedHelpArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelpCell", for: indexPath) as! HelpCell
		cell.layer.cornerRadius = 9
		
		cell.helpTitle.text = self.searchedHelpArray[indexPath.item].title!
		cell.backgroundColor = DesignUtilities.getTintColor()
		return cell
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showHelp" {
			let helpVc = segue.destination as! showHelpVC
			helpVc.help = selectedHelp
		}
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let help = helpArray[indexPath.item]
		selectedHelp = help
		performSegue(withIdentifier: "showHelp", sender: nil)
	}
}

// MARK: - Extension Functions
extension helpViewController {
	func getHelp() {
		self.helpArray = []
		self.helpArray.append(Help(title: "Searching", helpDescription: "Use the search bar located at the top of the screen to search for an item for the page you are on."))
		self.searchedHelpArray.append(Help(title: "Searching", helpDescription: "Use the search bar located at the top of the screen to search for an item for the page you are on."))
		
		self.helpArray.append(Help(title: "Loging Out", helpDescription: "Swipe down on the screen until you see a button titled 'LOGOUT'."))
		self.searchedHelpArray.append(Help(title: "Loging Out", helpDescription: "Swipe down on the screen until you see a button titled 'LOGOUT'."))
		
		self.helpArray.append(Help(title: "Change Email & Password", helpDescription: "Before entering database, click button labled 'Administrative Settings'."))
		self.searchedHelpArray.append(Help(title: "Changing Email & Password", helpDescription: "Before entering database, click button labled 'Administrative Settings'."))
		
		self.helpArray.append(Help(title: "Change Color Scheme", helpDescription: "Talk to your Lead Software Engineer."))
		self.searchedHelpArray.append(Help(title: "Change Color Scheme", helpDescription: "Talk to your Lead Software Engineer."))
	}
}
