//
//  BigPhotoVC.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/12/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class BigPhotoVC: UIViewController {
	
	var imageName: String?
	var desc: String?
	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var photoDescription: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		getPhoto()
		photo.layer.shadowRadius = 10
		photo.layer.cornerRadius = 9
		
		photoDescription.text = desc
    }
}

extension BigPhotoVC {
	func getPhoto() {
		let url = URL(string: imageName!)
		let resource = ImageResource(downloadURL: url!)
		photo.kf.setImage(with: resource, completionHandler: { (result) in
			switch result {
			case .success(_):
				print("Successfully gathered photo and descriptions from firebase storage")
			case .failure(let error):
				print(error.localizedDescription)
			}
		})
	}
}
