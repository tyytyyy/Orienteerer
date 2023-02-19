
//
//  SetupAssistant.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 1/3/23.
//
 
import UIKit
import HealthKit
class HealthStore{
    var healthStore:HKHealthStore? //creates variable healthStore of type HKHealthStore
    var heartRate:Double = 0.0
    var distance: Double = 0.0
    var pace: Double = 0.0
    init(){ //initializes healthStore as HKHealthStore() if HKHealthStore is available
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
            heartRate = 0.0
            distance = 0.0
            pace = 0.0
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void){ //requests authorization once, need to change what is needed
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                            HKObjectType.quantityType(forIdentifier: .heartRate)!])
        guard let healthStore = self.healthStore else { return completion(false)}
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
            guard error == nil else{
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            self.heartRate = data.quantity.doubleValue(for: unit)
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yyyy hh:mm s"
        }
        healthStore?.execute(query)
    }
    
    func getNewHeartRate() -> Double{
        return self.heartRate
    }
    
    func setNewDistance(){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else{
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
            self.heartRate = data.quantity.doubleValue(for: unit)
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yyyy hh:mm s"
        }
        healthStore?.execute(query)
    }
    
    func getNewDistance() -> Double{
        return self.distance
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
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yyyy hh:mm s"
        }
        healthStore?.execute(query)
    }
    
    func getNewPace() -> Double{
        return self.pace
    }
}
