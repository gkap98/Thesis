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
	var selectedProject: Project!
	@IBOutlet weak var homeCollectionView: UICollectionView!
	let cellScale: CGFloat = 0.6
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		homeCollectionView.dataSource = self
		homeCollectionView.delegate = self
		navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
		getProjects()
    }
	
}

// MARK: - Collection View Extension
extension PhotosHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosHomeCell", for: indexPath) as! PhotosHomeCell
		
		
		// Cell Design
		cell.shader.layer.cornerRadius = 10.0
		cell.shader.layer.masksToBounds = true
		cell.photo.layer.cornerRadius = 10.0
		cell.photo.layer.masksToBounds = true
		
		cell.projectTitle.text = self.data[indexPath.item].title
		let url = URL(string: self.data[indexPath.row].image!)
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
		if segue.identifier == "seePhotosSegue" {
			let photoVC = segue.destination as! AllPhotosVC
			photoVC.projectID = selectedProject.id
		}
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let project = data[indexPath.item]
		selectedProject = project
		
		performSegue(withIdentifier: "seePhotosSegue", sender: nil)
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
			}
			self.homeCollectionView.reloadData()
			//print(self.projectsArray[0].id!)
		}
	}
}
