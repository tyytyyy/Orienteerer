
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
    
    init(){ //initializes healthStore as HKHealthStore() if HKHealthStore is available
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
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
    
    func getHeartRate(){
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
        }
        healthStore?.execute(query)
    }
 
}
