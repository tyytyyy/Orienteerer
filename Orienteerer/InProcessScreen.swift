//
//  InProcessScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 12/7/22.
//
import CoreLocation
import MapKit
import UIKit

class InProcessScreen:UIViewController, CLLocationManagerDelegate{

    @IBOutlet var heartrateLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    var time:Int = 0
    let onesecond = 1.0
    let manager = CLLocationManager()
    @IBOutlet var mapView: MKMapView!
    static var transferrableMapView: MKMapView!
    static var array_of_times = [Int]()
    static var array_of_latitude = [Double]()
    static var array_of_longitude = [Double]()
    static var array_of_annotations = [MKPointAnnotation]()
    var ownHealthStore:HealthStore = HomeScreen().getAccess()
    override func viewDidLoad() {
        super.viewDidLoad()
        time = 0
        ownHealthStore = HomeScreen().getAccess()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        //self.updateHeartRate()
        //self.updateDistance()
        //self.updatePace()
        //self.updateTime()
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updating), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
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
        InProcessScreen.array_of_annotations.append(annotation1)
        self.mapView.addAnnotation(annotation1)
        InProcessScreen.transferrableMapView = mapView
        InProcessScreen.array_of_times.append(time)
        InProcessScreen.array_of_latitude.append(location.coordinate.latitude)
        InProcessScreen.array_of_longitude.append(location.coordinate.longitude)
    }
    
    public func getMapView() -> MKMapView {
        return mapView
        
    }
    @objc func updating(){
        ownHealthStore = HomeScreen().getAccess()
        //self.updateHeartRate()
        //self.updateDistance()
        //self.updatePace()
        setTime()
        //self.updateTime()
    }
    
    func setTime(){
        self.time = self.time + 1
    }
    /*
    func updateTime(){
        timeLabel.text = String(time)
    }
    
    func updateHeartRate(){
        heartrateLabel.text = String(ownHealthStore.getNewHeartRate())
    }
    
    func updateDistance(){
        distanceLabel.text = String(ownHealthStore.getNewDistance())
    }
    
    func updatePace(){
        paceLabel.text = String(ownHealthStore.getNewPace())
    }*/

    @IBAction func StopButton(_ sender: Any) {
        let ninthVC = self.storyboard?.instantiateViewController(withIdentifier: "EndScreenTwo") as! EndScreenTwo
                self.navigationController?.pushViewController(ninthVC, animated: true)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsScreen") as! Congratulationsscreen
                self.navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
