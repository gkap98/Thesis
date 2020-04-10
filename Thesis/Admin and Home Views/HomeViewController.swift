//
//  HomeViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	var gradientLayer: CAGradientLayer!
	
	@IBOutlet weak var estimatesBtn: UIButton!
	@IBOutlet weak var contactsBtn: UIButton!
	@IBOutlet weak var helpBtn: UIButton!
	@IBOutlet weak var companyTitle: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
		overrideUserInterfaceStyle = .dark
    }
	
	func setUpElements() {
		DesignUtilities.styleFilledBtn(estimatesBtn)
		DesignUtilities.styleFilledBtn(contactsBtn)
		DesignUtilities.styleFilledBtn(helpBtn)
	}

	
}
