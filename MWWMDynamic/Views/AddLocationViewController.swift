//
//  AddLocationViewController.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    lazy var viewModel: AddLocationViewModel = {
        return AddLocationViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed))
        mapView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func longPressed(sender: UIGestureRecognizer) {
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            viewModel.getPinnedLocation(locationOnMap: locationOnMap) { completion in
                if completion, let cityName = self.viewModel.pinnedLocation?.name {
                    self.addAnnotation(locationOnMap: locationOnMap, cityName: cityName)
                }
            }
        }
    }
    
    func addAnnotation(locationOnMap: CLLocationCoordinate2D, cityName: String) {
        mapView.removeAnnotations(self.mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationOnMap
        annotation.title = cityName
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)

       determineCurrentLocation()
    }
    
    func determineCurrentLocation() {
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers

       if CLLocationManager.locationServicesEnabled() {
           locationManager.requestLocation()
       }
    }

}

extension AddLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
 
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
 
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}

extension AddLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let reuseId = "locationPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
            pinView!.pinTintColor = UIColor.black
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {}
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let _ = view.annotation?.title! {                                
                present(viewModel.getAddLocationAlert(), animated: true, completion: nil)
            }
        }
    }
    
}
