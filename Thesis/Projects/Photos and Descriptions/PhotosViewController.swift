//
//  PhotosViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/11/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

// MARK: - View Contoller Extension
class PhotosViewController: UIViewController {

	@IBOutlet weak var photosCollectionView: UICollectionView!
	@IBOutlet weak var addPhotoBtn: UIButton!
	@IBOutlet weak var seeAllPhotosBtn: UIButton!
	
	var data = [PhotoDescriptors]()
	var projectID : String?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		// Setup buttons
		DesignUtilities.styleFloatingActionBtn(addPhotoBtn)
		DesignUtilities.styleFloatingActionBtn(seeAllPhotosBtn)


		
		navigationController?.navigationBar.prefersLargeTitles = true
		photosCollectionView.delegate = self
		photosCollectionView.dataSource = self
		
		let numberOfItemsInRow: CGFloat = 3
		let lineSpacing: CGFloat = 5
		let interItemSpacing: CGFloat = 2
		
		let width = (photosCollectionView.frame.width - (numberOfItemsInRow - 1) * interItemSpacing) / numberOfItemsInRow
		let height = width
		let layout = UICollectionViewFlowLayout()
		
		layout.itemSize = CGSize(width: width, height: height)
		layout.sectionInset = UIEdgeInsets.zero
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = lineSpacing
		layout.minimumInteritemSpacing = interItemSpacing
		
		photosCollectionView.setCollectionViewLayout(layout, animated: true)
		
		overrideUserInterfaceStyle = .dark
		
		getPhotoData()
		
    }
	@IBAction func refreshTapped(_ sender: Any) {
		viewDidLoad()
	}
	
	var selectedPhoto: PhotoDescriptors?
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "addPhoto" {
			let addPhotoVC = segue.destination as! addPhotoAndDescriptionViewController
			addPhotoVC.projectID = projectID
		}
		if segue.identifier == "showPhoto" {
			let bigPhoto = segue.destination as! BigPhotoVC
			bigPhoto.imageName = selectedPhoto?.imageName
			bigPhoto.desc = selectedPhoto?.photoDescription
		}
		if segue.identifier == "seeAllPhotos" {
			let seePhotoVC = segue.destination as! AllPhotosVC
			seePhotoVC.projectID = projectID
		}
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = data[indexPath.item]
		selectedPhoto = photo
		
		performSegue(withIdentifier: "showPhoto", sender: nil)
	}
	
}


// MARK: - Collection View Extension
extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell

		
		cell.layer.cornerRadius = 9
		cell.cellPhoto.layer.cornerRadius = 9
		cell.layer.borderWidth = 2
		cell.layer.borderColor = DesignUtilities.getMasterColor()
		
		let url = URL(string: self.data[indexPath.item].imageName!)
		let resource = ImageResource(downloadURL: url!)
		cell.cellPhoto?.kf.setImage(with: resource, completionHandler: { (result) in
			switch result {
			case .success(_):
				print("Successfully gathered photos and descriptions from firebase storage")
			case .failure(let error):
				print(error.localizedDescription)
			}
		})
		return cell
	}
}

// MARK: - Extension Functions
extension PhotosViewController {
	func getPhotoData() {
	self.data = []
	
	let databaseRef = Database.database().reference().child("Projects").child(projectID!).child("Photos")
	databaseRef.observeSingleEvent(of: .value) { (snapshot) in
		for snap in snapshot.children {
			let databaseSnap = snap as! DataSnapshot
			let key = databaseSnap.key
			
			let ref = databaseRef.child(key)
			ref.observeSingleEvent(of: .value) { (snapshot) in
				let dict = snapshot.value as! NSDictionary
				let imageURL = dict["imageURL"] as! String
				let photoDescription = dict["description"] as! String
				let photoID = dict["id"] as! String
				
				self.data.append(PhotoDescriptors(imageName: imageURL, photoDescription: photoDescription, id: photoID))
				self.photosCollectionView.reloadData()
			}
		}
	}
}
}
