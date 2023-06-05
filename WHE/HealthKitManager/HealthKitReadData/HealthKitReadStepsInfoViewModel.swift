//
//  HealthKitReadStepsInfoViewModel.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 24/03/23.
//

import HealthKit

class HealthKitReadStepsInfoViewModel {
  let healthStore = HKHealthStore()
  
  // MARK: - Read today step count
  func getStepsCountData(completion: @escaping (Double) -> Void) {
    let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(
      withStart: startOfDay,
      end: now,
      options: .strictStartDate
    )
    
    let query = HKStatisticsQuery(
      quantityType: stepsQuantityType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum
    ) { _, result, _ in
      guard let result = result, let sum = result.sumQuantity() else {
        completion(0.0)
        return
      }
      completion(sum.doubleValue(for: HKUnit.count()))
    }
    
    healthStore.execute(query)
  }
}
