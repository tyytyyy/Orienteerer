//
//  SetupAssistant.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 1/3/23.
//

import UIKit
import HealthKit
class SetupAssistant: NSObject {
    var healthStore:HKHealthStore?
    func gainAuthorization(){
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                            HKObjectType.quantityType(forIdentifier: .heartRate)!])

        healthStore!.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                // Handle the error here.
            }
        }
    }
    func setupHealthKit() {
        
        if HKHealthStore.isHealthDataAvailable(){
            
            healthStore = HKHealthStore()
        }
         
    }

}
