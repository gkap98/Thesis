//
//  PhotosHomeViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/12/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

// MARK: - View Controller Extension
class PhotosHomeViewController: UIViewController {
	@IBAction func refreshBtnTapped(_ sender: Any) {
		viewDidLoad()
	}

	var data = [Project]()
	var searchData = [Project]()
	var selectedProject: Project!
	@IBOutlet weak var homeCollectionView: UICollectionView!
	@IBOutlet weak var addButton: UIButton!
	@IBOutlet weak var searchBar: UISearchBar!
	let cellScale: CGFloat = 0.6
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		homeCollectionView.dataSource = self
		homeCollectionView.delegate = self
		navigationController?.navigationBar.prefersLargeTitles = true
		overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.
		DesignUtilities.styleFloatingActionBtn(addButton)
		setUpSearchBar()
		getProjects()
    }
	
}

// MARK: - Collection View Extension
extension PhotosHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return searchData.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosHomeCell", for: indexPath) as! PhotosHomeCell
		
		
		// Cell Design
		cell.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9658232331, alpha: 1)
		cell.layer.borderWidth = 2
		cell.layer.cornerRadius = 9


		
		cell.projectTitle.text = self.searchData[indexPath.item].title
		cell.projectAddress.text = self.searchData[indexPath.item].address
		let url = URL(string: self.searchData[indexPath.row].image!)
		let resource = ImageResource(downloadURL: url!)
		cell.photo?.kf.setImage(with: resource, completionHandler: { (result) in
			switch result {
			case .success(_):
				print("Successfully gathered Projects from firebase storage")
			case .failure(let error):
				print(error.localizedDescription)
			}
		})
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showProjectDetail" {
			let projectDetailVC = segue.destination as! ProjectDetailTableViewController
			projectDetailVC.selectedProjectID = selectedProject.id
			projectDetailVC.pinTitleForProject = selectedProject.title
		}
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let project = data[indexPath.item]
		selectedProject = project
		
		performSegue(withIdentifier: "showProjectDetail", sender: nil)
	}
}

//MARK: - Extension Functions
extension PhotosHomeViewController {
	func getProjects() {
		self.data = []
		let projectsRef = Database.database().reference().child("Projects")
		projectsRef.observeSingleEvent(of: .value) { (snapshot) in
			for snap in snapshot.children {
				let projectSnap = snap as! DataSnapshot
				let projectDict = projectSnap.value as! [String:AnyObject]
				let title = projectDict["Title"] as! String
				let address = projectDict["Street Address"] as! String
				let urlString = projectDict["Image URL"] as! String
				let projectID = projectDict["Project ID"] as! String
				
				self.data.append(Project(titled: title, address: address, imageName: urlString, id: projectID))
				self.searchData.append(Project(titled: title, address: address, imageName: urlString, id: projectID))
			}
			self.homeCollectionView.reloadData()
			//print(self.projectsArray[0].id!)
		}
	}

}

extension PhotosHomeViewController: UISearchBarDelegate {
	private func setUpSearchBar() {
		searchBar.delegate = self
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard !searchText.isEmpty else {
			searchData = data
			homeCollectionView.reloadData()
			searchBar.showsCancelButton = false
			return
		}
		searchBar.showsCancelButton = true
		searchData = data.filter({ data -> Bool in
			(
				(data.title?.lowercased().contains(searchText.lowercased()))! ||
				(data.address?.lowercased().contains(searchText.lowercased()))!
			)
		})
		homeCollectionView.reloadData()
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchData = data
		searchBar.text = ""
		searchBar.showsCancelButton = false
		homeCollectionView.reloadData()
	}
}
