
//
//  SetupAssistant.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 1/3/23.
//
 
import UIKit
import HealthKit
import CoreLocation
import MapKit
class HealthStore{
    let healthStore = HKHealthStore() //creates variable healthStore of type HKHealthStore
    var heartRate:Double = 0.0
    var distance: Double = 0.0
    public var mapView: MKMapView!
    public let manager = CLLocationManager()
    var pace: Double = 0.0
    init(){ //initializes healthStore as HKHealthStore() if HKHealthStore is available
        heartRate = 0.0
        distance = 0.0
        pace = 0.0
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void){ //requests authorization once, need to change what is needed
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .runningSpeed)!,
                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                            HKObjectType.quantityType(forIdentifier: .heartRate)!])
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            completion(success)
        }
        
    }
    
    func setNewHeartRate(){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
            return
        }
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options:.strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) {(sample, result, error) in
            guard let result = result else { return } //result is []
            let data = result[0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            self.heartRate = data.quantity.doubleValue(for: unit)
        }
        healthStore.execute(query)
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        render(location: locations.last!)
    }
    public func render( location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.mapView.addAnnotation(annotation1)
    }
    public func getMapView() -> MKMapView{
        return mapView
    }
    func setNewDistance(){
        guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Something went wrong retrieving quantity type distanceWalkingRunning")
        }
        let date =  Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)

        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
            var value: Double = 0

            if error != nil {
                print("something went wrong")
            } else if let quantity = statistics?.sumQuantity() {
                value = quantity.doubleValue(for: HKUnit.mile())
                self.distance = value
            }
        }
        healthStore.execute(query)
    }
    
    func setNewPace(){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .runningSpeed) else{
            return
        }
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options:.strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) {(sample, result, error) in
            guard error == nil else{
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            self.pace = data.quantity.doubleValue(for: unit)
        }
        healthStore.execute(query)
    }
    
     func getNewDistance() -> Double{
         return self.distance
     }
     
    func getNewPace() -> Double{
        return self.pace
    }
     
    func getNewHeartRate() -> Double{
        return self.heartRate
    }
    
    
}
