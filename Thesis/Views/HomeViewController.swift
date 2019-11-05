//
//  HomeViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	@IBOutlet weak var projectsBtn: UIButton!
	@IBOutlet weak var estimatesBtn: UIButton!
	@IBOutlet weak var contactsBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
	
	func setUpElements() {
		Utilities.styleFilledBtn(projectsBtn)
		Utilities.styleFilledBtn(estimatesBtn)
		Utilities.styleFilledBtn(contactsBtn)

	}
	
}
