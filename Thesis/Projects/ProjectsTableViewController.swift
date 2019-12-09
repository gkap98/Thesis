//
//  ProjectsTableViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/8/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//

import UIKit
import Firebase

class ProjectsTableViewController: UITableViewController {
	
	var projectsArray = [Project]()
	
	func getProjectsFromDatabase() {
		self.projectsArray = []
		let projectsRef = Database.database().reference().child("Projects")
		let storageRef = Storage.storage().reference().child("Images")
		projectsRef.observeSingleEvent(of: .value) { (snapshot) in
			for snap in snapshot.children {
				let projectSnap = snap as! DataSnapshot
				let projectDict = projectSnap.value as! [String:AnyObject]
				let title = projectDict["title"] as! String
				let address = projectDict["streetAddrs"] as! String
				
				let imageURL = "kapBar"//projectDict["projectImageURL"] as! String
				
				self.projectsArray.append(Project(titled: title, address: address, imageName: imageURL))
			}
			self.tableView.reloadData()
		}
	}


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		getProjectsFromDatabase()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

		return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return projectsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)

		DesignUtilities.styleCircleImageWithBorder(cell.imageView!)
        // Configure the cell...
		cell.textLabel?.text = projectsArray[indexPath.row].title
		cell.detailTextLabel?.text = projectsArray[indexPath.row].address
		
		cell.imageView?.image = projectsArray[indexPath.row].image
		
        return cell
    }
	



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
