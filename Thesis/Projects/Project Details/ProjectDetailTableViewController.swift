//
//  ProjectDetailTableViewController.swift
//  Thesis
//
//  Created by Gavin Kaepernick on 12/21/19.
//  Copyright © 2019 Gavin Kaepernick. All rights reserved.
//
import UIKit
import MapKit
import Foundation
import Firebase
import Kingfisher
import CoreLocation

class ProjectDetailTableViewController: UITableViewController {
	
	// MARK: - Outlets and Variables
	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var projectImage: UIImageView!
	@IBOutlet weak var street: UILabel!
	@IBOutlet weak var city: UILabel!
	@IBOutlet weak var state: UILabel!
	@IBOutlet weak var zip: UILabel!
	@IBOutlet weak var projectTitle: UILabel!
	@IBOutlet weak var startYear: UILabel!
	@IBOutlet weak var endYear: UILabel!
	@IBOutlet weak var cost: UILabel!
	@IBOutlet weak var uid: UILabel!
	@IBOutlet weak var picDiscrptBtn: UIButton!
	@IBOutlet weak var addCharacteristicBtn: UIButton!
	var selectedProjectID: String?
	var pinTitleForProject: String?
	var projectAddress: String?
	var pin: customPin?
	var pinTitle: String?
	
	// MARK: - View Did Load
	override func viewDidLoad() {
		navigationController?.navigationBar.prefersLargeTitles = true
		getProjectDetail()
		DesignUtilities.styleCircleImageWithBorder(projectImage)
		projectImage.layer.shadowRadius = 12.0
		projectImage.layer.shadowColor = #colorLiteral(red: 0.02118486725, green: 0.1695403755, blue: 0.2873623371, alpha: 1)
		DesignUtilities.menuStylebutton(picDiscrptBtn)
		DesignUtilities.menuStylebutton(addCharacteristicBtn)
		checkLocationServices()
	}
	
		
		
	// MARK: - MapKit Code
		let locationManager = CLLocationManager()
		let regionInMeters: Double = 5000
	/*
		func centerViewOnUserLocation() {
			if let location = locationManager.location?.coordinate {
				let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
				map.setRegion(region, animated: true)
			}
		}
	*/


	// MARK: - Button Actions
	@IBAction func picDescriptBtnTapped(_ sender: Any) {
		performSegue(withIdentifier: "next", sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "next" {
			let destinationVC = segue.destination as! PhotosViewController
			
			destinationVC.projectID = selectedProjectID!
		}
		if segue.identifier == "addChar" {
			let destinationVC = segue.destination as! AddCharVC
			
			destinationVC.projectID = selectedProjectID!
		}
	}
}
// MARK: - MapKit Delegate Extension
extension ProjectDetailTableViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
	}
}

// MARK: - Extension Functions
extension ProjectDetailTableViewController {
	func checkLocationPermissions() {
		switch CLLocationManager.authorizationStatus() {
		case .authorizedWhenInUse:
			let projectRef = Database.database().reference().child("Projects").child(selectedProjectID!)
			projectRef.observeSingleEvent(of: .value) { (snapshot) in
				let projectDict = snapshot.value as? NSDictionary
				let street = projectDict!["Street Address"] as? String
				let city = projectDict!["City"] as? String
				let state = projectDict!["State"] as? String
				let zip = projectDict!["Zip"] as? String
				
				let pStreet = street
				let pCity = city
				let pState = state
				let pZip = zip
				self.getCoordinatesFromAddress(address: "\(pStreet!), \(pCity!), \(pState!) \(pZip!)")
			}
			break
		case .denied:
			// Show alert about how to set up
			break
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
			break
		case .restricted:
			// Show an alert letting them know that it is restricted
			break
		case .authorizedAlways:
			break
		@unknown default:
			// If something else happens give an error
			fatalError()
		}
	}
	func setupLocationManager() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}
	func checkLocationServices() {
		if CLLocationManager.locationServicesEnabled() {
			setupLocationManager()
			checkLocationPermissions()
		} else {
			// Make sure that Location Services are turned on
			let alert = UIAlertController(title: "Error", message: "Please make sure that your Location Services are turned ON in order to see location on map. Settings->Privacy->Location Services-> *ON*", preferredStyle: .alert)
			self.present(alert, animated: true)
			alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
		}
	}
	
	func getCoordinatesFromAddress(address: String) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { (placemarks, error) in
			if error != nil {
				print(error!)
			} else {
				if let placemark = placemarks?.first {
					let projectCoordinates: CLLocationCoordinate2D = placemark.location!.coordinate
					let region = MKCoordinateRegion.init(center: projectCoordinates, latitudinalMeters: self.regionInMeters, longitudinalMeters: self.regionInMeters)
					self.map.setRegion(region, animated: true)
					let pin = customPin(coordinate: projectCoordinates, pinTitle: self.pinTitleForProject!, pinSubTitle: self.street.text!)
					self.map.addAnnotation(pin)

				}
			}
		}
	}
	// MARK: - Project Info Setup
	func getProjectDetail() {
		let projectRef = Database.database().reference().child("Projects").child(selectedProjectID!)
		projectRef.observeSingleEvent(of: .value) { (snapshot) in
			let projectDict = snapshot.value as? NSDictionary
			let title = projectDict!["Title"] as? String
			let address = projectDict!["Street Address"] as? String
			let urlString = projectDict!["Image URL"] as? String
			let projectID = projectDict!["projectID"] as? String
			let city = projectDict!["City"] as? String
			let state = projectDict!["State"] as? String
			let zip = projectDict!["Zip"] as? String
			let start = projectDict!["Start Date"] as? String
			let end = projectDict!["End Date"] as? String
			let cost = projectDict!["Total Cost"] as? String
			
			
			let url = URL(string: urlString!)
			let resource = ImageResource(downloadURL: url!)
			self.projectImage.kf.setImage(with: resource, completionHandler: { (result) in
				switch result {
				case .success(_):
					print("Successfully gathered photo for projects display")
				case .failure(let error):
					print(error.localizedDescription)
				}
			})
			self.projectTitle.text = title
			self.street.text = address
			self.city.text = city
			self.state.text = state
			self.zip.text = zip
			self.startYear.text = start
			self.endYear.text = end
			self.cost.text = cost
			self.uid.text = projectID
			
		}
	}
	
	
}


