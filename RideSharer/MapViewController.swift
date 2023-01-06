//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let location = locations.first {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
      }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      if status == .denied {
        showLocationAccessDeniedAlert()
      }
    }
    func showLocationAccessDeniedAlert() {
      let alert = UIAlertController(title: "Location Access Denied", message: "Please grant location access in the Settings app to use this feature.", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
        if let url = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
      }
      alert.addAction(cancelAction)
      alert.addAction(openSettingsAction)
      present(alert, animated: true, completion: nil)
    }

    
}
