//
//  MapViewController.swift
//  GeoLocalization
//
//  Created by Developer on 08.12.2022.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let kazakhUser = Users(name: "Ибрагим",
                           coordinate: CLLocationCoordinate2D.init(latitude: 51.0890503, longitude: 71.404632),
                           info: "Пользователь из Астаны")
    let russianUser = Users(name: "Андрей", coordinate: CLLocationCoordinate2D.init(latitude: 55.751754, longitude: 37.662709), info: "Пользователь из Москвы")
    let turkishUser = Users(name: "Мехмет", coordinate: CLLocationCoordinate2D.init(latitude: 39.9004151, longitude: 32.8064158), info: "Пользователь из Анкары")
    let americanUser = Users(name: "Кевин", coordinate: CLLocationCoordinate2D.init(latitude: 37.427249, longitude: -122.1661477), info: "Пользователь из Сан-Франциско")
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()

        mapView.addAnnotations([kazakhUser, russianUser, turkishUser, americanUser])
        mapView.mapType = .hybrid
        
//        showRouteOnMap(pickupCoordinate: initialLocation, destinationCoordinate: russianUser.coordinate)
        
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        findUserLocation()
        
        showRouteOnMap(pickupCoordinate: kazakhUser.coordinate, destinationCoordinate: russianUser.coordinate)
    }
    
    private func findUserLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                //for getting just one route
                if let route = unwrappedResponse.routes.first {
                    //show on map
                    self.mapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                }
            }
        }

    
    private func setupView() {
        
        title = "Геолокация"
        view.backgroundColor = .white
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
            
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможна!")
        case .notDetermined:
            print("Определение локации не запрошено!")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location")

            mapView.setCenter(location.coordinate, animated: true)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                    mapView.setRegion(region, animated: false)

        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
}


