//
//  ProjectsViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
	@IBOutlet weak var showProjectsBtn: UIButton!
	@IBOutlet weak var createNewBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
	func setUpElements() {
		Utilities.styleFilledBtn(showProjectsBtn)
		Utilities.styleFilledBtn(createNewBtn)
	}

}
