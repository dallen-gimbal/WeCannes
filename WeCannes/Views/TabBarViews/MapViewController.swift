//
//  MapViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    //MARK: MapView Code
    func setupMapView() {
           view.addSubview(mapView)
           mapView.translatesAutoresizingMaskIntoConstraints = false
           mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
           mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
        }
       
    func checkLocationAuthorization() {
        let permissions = Permissions.init()
        let locationStatus = permissions.checkLocationStatus()
        if (locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse) {
            print("authorized")
            mapView.showsUserLocation = true
            followUserLocation()
        }
    }
    
    func followUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
            mapView.setRegion(region, animated: true)
        }
    }
}
