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
    var array_times = InProcessScreen.array_of_times
    var array_latitude = InProcessScreen.array_of_latitude
    var array_longitude = InProcessScreen.array_of_longitude
    var time:Int = 0
    let onesecond = 1.0
    @IBOutlet var doneButton: UIButton!
    /*lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()*/
    @IBOutlet var mapView: MKMapView! = InProcessScreen.transferrableMapView
    override func viewDidLoad(){
       
        super.viewDidLoad()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        for annotation2 in InProcessScreen.array_of_annotations{
            self.mapView.addAnnotation(annotation2)
        }
        time = 0
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updating), userInfo: nil, repeats: true)
        view.bringSubviewToFront(doneButton)
    }
    
    @objc func updating(){
        
        self.time = self.time + 1
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        render(location: locations.last!)
    }
    func render( location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(thirdVC, animated: true)
    }
}
