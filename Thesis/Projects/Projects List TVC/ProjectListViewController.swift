//
//  ProjectListViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 2/9/20.
//  Copyright © 2020 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProjectListViewController: UIViewController {

	@IBOutlet weak var projectTableView: UITableView!
	@IBOutlet var addButton: UIButton!
	@IBOutlet weak var refreshButton: UIBarButtonItem!
	@IBOutlet weak var searchBar: UISearchBar!
	
	@IBAction func refreshTapped(_ sender: Any) {
		viewDidLoad()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		projectTableView.dataSource = self
		projectTableView.delegate = self
		navigationController!.navigationBar.prefersLargeTitles = true
		getProjectsFromDatabase()
		DesignUtilities.styleFloatingActionBtn(addButton)
	}
	
	
	var projectsArray = [Project]()
	var selectedProject: Project?

}

// MARK: - Table View Extension
extension ProjectListViewController: UITableViewDataSource, UITableViewDelegate {
	// MARK: - Table View Setters
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projectsArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectListCell

		DesignUtilities.styleCircleImageWithBorder(cell.projectImage!)
		cell.projectImage.layer.borderColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		// Configure the cell...
		cell.projectTitle?.text = self.projectsArray[indexPath.row].title
		cell.projectAddress?.text = self.projectsArray[indexPath.row].address
		
		let url = URL(string: self.projectsArray[indexPath.row].image!)
		let resource = ImageResource(downloadURL: url!)
		cell.projectImage?.kf.setImage(with: resource, completionHandler: { (result) in
			switch result {
			case .success(_):
				print("Successfully gathered Projects from firebase storage")
			case .failure(let error):
				print(error.localizedDescription)
			}
		})
        return cell
    }
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
		return true
    }
    // Override to support editing the table view.
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		let ref = Database.database().reference().child("Projects")
		let storageRef = Storage.storage().reference().child("Images").child(projectsArray[indexPath.row].id!)
        if editingStyle == .delete {
			ref.child(projectsArray[indexPath.row].id!).removeValue { (error, reference) in
				if error != nil {
					print("Error Deleting Project From Database: \(error!)")
				} else {
					storageRef.delete { (error) in
						if error != nil {
							print("Error Removing Storage File: \(error!)")
						}
					}
					self.projectsArray.remove(at: indexPath.row)
					self.projectTableView.deleteRows(at: [indexPath], with: .automatic)
				}
			}
        }
	}
	

	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showProjectDetail" {
			let projectDetailTVC = segue.destination as! ProjectDetailTableViewController
			
			projectDetailTVC.selectedProjectID = selectedProject?.id
			projectDetailTVC.pinTitleForProject = selectedProject?.title
		}
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let project = projectsArray[indexPath.row]
		selectedProject = project
		
		performSegue(withIdentifier: "showProjectDetail", sender: nil)
	}
}

// MARK: - Extension Functions
extension ProjectListViewController {
	func getProjectsFromDatabase() {
		self.projectsArray = []
		let projectsRef = Database.database().reference().child("Projects")
		projectsRef.observeSingleEvent(of: .value) { (snapshot) in
			for snap in snapshot.children {
				let projectSnap = snap as! DataSnapshot
				let projectDict = projectSnap.value as! [String:AnyObject]
				let title = projectDict["Title"] as! String
				let address = projectDict["Street Address"] as! String
				let urlString = projectDict["Image URL"] as! String
				let projectID = projectDict["Project ID"] as! String
				
				self.projectsArray.append(Project(titled: title, address: address, imageName: urlString, id: projectID))
			}
			self.projectTableView.reloadData()
			//print(self.projectsArray[0].id!)
		}
	}
}


