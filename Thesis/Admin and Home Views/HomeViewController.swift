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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
	
	func setUpElements() {
		DesignUtilities.styleFilledBtn(projectsBtn)
		DesignUtilities.styleFilledBtn(estimatesBtn)

	}
	
}
