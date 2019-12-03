//
//  ProjectsTableViewViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 11/5/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

struct Project {
	var title: String
	var address: String
}

class ProjectsList: UIViewController, UITableViewDelegate, UITableViewDataSource {
	var projects = [Project]()
	
	override func viewDidLoad() {
		  super.viewDidLoad()
		  // THIS IS WHERE THE INFORMATION FROM THE DATABASE HAS TO GET TAKEN IN FOR THE TABLE CELLS
		  
		  observeProject() 	// Function Above Knows What To Do
	  }

	
	func observeProject() {
		let projectRef = Database.database().reference().child("Projects")
		
		projectRef.observe(.value, with: { snapshot in
			
			var tempProjects = [Project]()
			
			for child in snapshot.children {
				if let childSnapshot = child as? DataSnapshot,
					let dictionary = childSnapshot.value as? [String:Any],
					let title = dictionary["title"] as? String,
					let address = dictionary["address"] as? String {
					
					let project = Project(title: title, address: address)
					tempProjects.append(project)
				}
			}
			self.projects = tempProjects
		})
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projects.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCells
		cell.set(project: projects[indexPath.row])
		return cell
	}
	
  
}
