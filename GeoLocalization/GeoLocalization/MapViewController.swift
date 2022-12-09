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
import Contacts

class MapViewController: UIViewController {
    
    let kazakhUser = Users(name: "Ибрагим",
                           coordinate: CLLocationCoordinate2D.init(latitude: 51.0890503, longitude: 71.404632),
                           info: "Пользователь из Астаны")
    let russianUser = Users(name: "Андрей", coordinate: CLLocationCoordinate2D.init(latitude: 55.751754, longitude: 37.662709), info: "Пользователь из Москвы")
    let turkishUser = Users(name: "Мехмет", coordinate: CLLocationCoordinate2D.init(latitude: 39.9004151, longitude: 32.8064158), info: "Пользователь из Анкары")
    let americanUser = Users(name: "Кевин", coordinate: CLLocationCoordinate2D.init(latitude: 37.427249, longitude: -122.1661477), info: "Пользователь из Сан-Франциско")
    
    
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    var finalDestination = CLLocationCoordinate2D()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.addAnnotations([kazakhUser, russianUser, turkishUser, americanUser])
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        findUserLocation()
        setupNavigationItem()
        tapOnMap()
        showDirection()
    }
    
    func showDirection() {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: myPosition.latitude, longitude: myPosition.longitude), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: finalDestination.latitude, longitude: finalDestination.longitude), addressDictionary: nil))
                request.requestsAlternateRoutes = true
                request.transportType = .automobile

                let directions = MKDirections(request: request)

                directions.calculate { [unowned self] response, error in
                    guard let unwrappedResponse = response else { return }

                    for route in unwrappedResponse.routes {
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    }
                }
    }
    
    private func findUserLocation() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Где я?", style: .done, target: self, action: #selector(updateLocation))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Убрать метки", style: .plain, target: self, action: #selector(removeAnnotations))
    }
    
    @objc func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    @objc func removeAnnotations() {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
    }
    
    func tapOnMap() {
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        longPressGR.minimumPressDuration = 1
        mapView.addGestureRecognizer(longPressGR)
    }
    
    @objc func addPin(sender: UIGestureRecognizer) {
        
        let location = sender.location(in: mapView)
        
        
        let locCoord = mapView.convert(location, toCoordinateFrom: mapView)
        
        finalDestination = locCoord
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Место"
        annotation.subtitle = "Место, куда мне нужно"
        
        mapView.addAnnotation(annotation)
    }
    
//    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
//
//            let request = MKDirections.Request()
//            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
//            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
//            request.requestsAlternateRoutes = true
//            request.transportType = .automobile
//
//            let directions = MKDirections(request: request)
//
//            directions.calculate { [unowned self] response, error in
//                guard let unwrappedResponse = response else { return }
//
//                //for getting just one route
//                if let route = unwrappedResponse.routes.first {
//                    //show on map
//                    self.mapView.addOverlay(route.polyline)
//                    //set the map area to show the route
//                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
//                }
//            }
//        }

    
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
            let latitude = location.coordinate.latitude
            let longtude = location.coordinate.longitude
            
            print("Got Location \(String(describing: latitude)), \(longtude)")
            
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longtude)
            mapView.setCenter(center, animated: true)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
            mapView.setRegion(region, animated: true)
            
            myPosition = location.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
}


