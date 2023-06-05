//
//  HealthKitPermissionsViewModel.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 24/03/23.
//

import HealthKit

class HealthKitPermissionsViewModel {
  let readStepsViewModel = HealthKitReadStepsInfoViewModel()
  let store = HKHealthStore()
  let permissionTitle = "Health Access is Needed for Activity Rewards"
  let permissionMessage = "To track your progress towards activity rewards, Whole Health needs access to your steps data."
  let alertButtonTitles = ["Cancel", "Understood"]
  
  // MARK: - Show Health kit Presmission Alert
  func getAccess(completionHandler: @escaping (HKAuthorizationStatus)->Void){
    let allTypes = Set([ HKObjectType.quantityType(forIdentifier: .stepCount)!])
    store.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
      if !success {
        completionHandler(.notDetermined)
      } else {
        completionHandler(self.healthKitAccess())
        do {
          guard HKHealthStore.isHealthDataAvailable() else {
            completionHandler(.notDetermined)
            print("HealthkitSetupError.notAvailableOnDevice")
            return
          }
        }
      }
    }
  }
  
  // MARK: - Health kit Presmissions Status
  func healthKitAccess() -> HKAuthorizationStatus {
    let stepsType:HKQuantityType! = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    let status:HKAuthorizationStatus = store.authorizationStatus(for: stepsType)
    switch (status) {
    case .sharingAuthorized:
      readStepsViewModel.getStepsCountData(completion: { (stepsCount) in
        print("Step count: \(stepsCount)")
      })
      return status
    case .sharingDenied:
      return status
    case .notDetermined:
      return status
    default:
      break;
    }
    return .notDetermined
  }
}
