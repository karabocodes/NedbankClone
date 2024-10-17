//
//  TransactionsViewController.swift
//  NedbankClone
//
//  Created by Nagarro on 2024/08/05.
//
import UIKit
import MapKit
import CoreLocation

class TransactionsViewController: UIViewController, CLLocationManagerDelegate {
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.isHidden = true
        return map
    }()
    
    private let findBranchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Nearest Branch", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    
    private let mockBranches = [
        Branch(name: "Nedbank Sandton", coordinate: CLLocationCoordinate2D(latitude: -26.107567, longitude: 28.056702)),
        Branch(name: "Nedbank Rosebank", coordinate: CLLocationCoordinate2D(latitude: -26.146416, longitude: 28.043348)),
        Branch(name: "Nedbank Johannesburg CBD", coordinate: CLLocationCoordinate2D(latitude: -26.204103, longitude: 28.047304)),
        Branch(name: "Nedbank Melrose Arch", coordinate: CLLocationCoordinate2D(latitude: -26.131876, longitude: 28.067104)),
        Branch(name: "Nedbank Fourways", coordinate: CLLocationCoordinate2D(latitude: -26.009866, longitude: 28.011465))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocationManager()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(findBranchButton)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        findBranchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            findBranchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findBranchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            findBranchButton.widthAnchor.constraint(equalToConstant: 200),
            findBranchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        findBranchButton.addTarget(self, action: #selector(findBranchButtonTapped), for: .touchUpInside)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    @objc private func findBranchButtonTapped() {
        print("Find Branch button tapped")
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            showLocationPermissionAlert()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        guard let location = locations.last else { return }
        userLocation = location.coordinate
        centerMapOnLocation(location: location)
        locationManager.stopUpdatingLocation()
        displayNearbyBranches()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }
    
    private func displayNearbyBranches() {
        mapView.removeAnnotations(mapView.annotations)
        
        for branch in mockBranches {
            let annotation = MKPointAnnotation()
            annotation.coordinate = branch.coordinate
            annotation.title = branch.name
            mapView.addAnnotation(annotation)
        }
        
        mapView.isHidden = false
        findBranchButton.isHidden = true
    }
    
    private func showLocationPermissionAlert() {
        let alert = UIAlertController(title: "Location Access Required", message: "Please enable location access in Settings to find nearby branches.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

struct Branch {
    let name: String
    let coordinate: CLLocationCoordinate2D
}
