//
//  AllPhotosVC.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/13/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class AllPhotosVC: UIViewController {

	@IBOutlet weak var collectionview: UICollectionView!
	var projectID: String!
	var data = [PhotoDescriptors]()
	
	override func viewDidLoad() {
        super.viewDidLoad()

	  // Do any additional setup after loading the view.
		  navigationController?.navigationBar.prefersLargeTitles = true
		  collectionview.delegate = self
		  collectionview.dataSource = self
		  
		  getPhotoData()
    }
}

extension AllPhotosVC: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramLikeCell", for: indexPath) as! InstagramLikeCell

	
		cell.photoDescription.text = self.data[indexPath.item].photoDescription!
		
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
		
		cell.cellPhoto.layer.cornerRadius = 10
		cell.cellPhoto.layer.masksToBounds = false
		cell.contentView.layer.cornerRadius = 4
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        cell.contentView.layer.masksToBounds = false
		cell.layer.masksToBounds = false
		return cell
	}
}

extension AllPhotosVC {
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
					self.collectionview.reloadData()
				}
			}
		}
	}
}
