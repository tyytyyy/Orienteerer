//
//  SetupAssistant.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 1/3/23.
//

import UIKit
import HealthKit

let healthStore = HKHealthStore()

    
let allTypes = Set([HKObjectType.workoutType(),
                    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                    HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                    HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                    HKObjectType.quantityType(forIdentifier: .heartRate)!])
func authorize(){
    healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
        if !success {
            authorize()
            // Handle the error here.
        }
    }
}

        


