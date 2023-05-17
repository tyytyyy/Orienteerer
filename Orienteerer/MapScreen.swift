//
//  MapScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 3/26/23.
//

import CoreLocation
import MapKit
import UIKit
import _MapKit_SwiftUI

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
        for time in InProcessScreen.array_of_times{
            for time1 in ConfirmationScreen.inttimelist{
                if time == time1 {
                    let index = InProcessScreen.array_of_times.firstIndex(of: time)!
                    let coordinate = CLLocationCoordinate2D(latitude: InProcessScreen.array_of_latitude[index], longitude: InProcessScreen.array_of_longitude[index]);
                    setPinUsingMKAnnotation(location: coordinate)
                }
                
            }
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
    func setPinUsingMKAnnotation(location: CLLocationCoordinate2D) {
        let pin1 = MapPin(title: "Here", locationName: "Device Location", coordinate: location)
        mapView.addAnnotations([pin1])
    }
    
}
class MapPin: NSObject, MKAnnotation {
   let title: String?
   let locationName: String
   let coordinate: CLLocationCoordinate2D
init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
      self.title = title
      self.locationName = locationName
      self.coordinate = coordinate
   }
}

class ViewController: UIViewController{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        let image = #imageLiteral(resourceName: "Untitled-1")
        annotationView?.image = image
        return annotationView
    }

}
