//
//  MapScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 3/26/23.
//

import CoreLocation
import MapKit
import UIKit

class MapScreen: UIViewController, CLLocationManagerDelegate
{
    let manager = CLLocationManager()
    @IBOutlet var doneButton: UIButton!
    /*lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()*/
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad(){
        super.viewDidLoad()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        view.bringSubviewToFront(doneButton)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        render(location: locations.last!)
    }
    func render( location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.mapView.addAnnotation(annotation1)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(thirdVC, animated: true)
    }
}
