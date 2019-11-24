//
//  ProjectCells.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 11/5/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class ProjectCells: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	

	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setUpElements()
	}
	
	func setUpElements() {
		//Utilities.styleCircleImageWithBorder(contentImage)
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	func set(project:Project) {
		titleLabel.text = project.title
		addressLabel.text = project.address
	}
}
