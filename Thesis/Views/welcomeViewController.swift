//
//  welcomeViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/2/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController {
	@IBOutlet weak var welcomeBtn: UIButton!
	@IBOutlet weak var adminBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
    
	func setUpElements() {
		DesignUtilities.styleFilledBtn(welcomeBtn)
		DesignUtilities.styleFilledBtn(adminBtn)
	}

}
