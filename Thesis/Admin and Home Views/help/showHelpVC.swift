//
//  showHelpVC.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 3/2/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit

class showHelpVC: UIViewController {

	@IBOutlet weak var helpTitle: UILabel!
	@IBOutlet weak var helpDescription: UILabel!
	var help: Help!
    override func viewDidLoad() {
        super.viewDidLoad()

		helpTitle.text = help.title
		helpDescription.text = help.helpDescription
    }
}
