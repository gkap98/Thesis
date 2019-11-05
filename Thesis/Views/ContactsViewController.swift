//
//  ContactsViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 10/31/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
	@IBOutlet weak var allContactsBtn: UIButton!
	@IBOutlet weak var createNewBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
	
	func setUpElements() {
		Utilities.styleFilledBtn(allContactsBtn)
		Utilities.styleFilledBtn(createNewBtn)
	}
}
