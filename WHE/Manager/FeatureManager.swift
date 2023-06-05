//
//  FeatureManager.swift
//  WHE
//
//  Created by Pratima Pundalik on 23/01/23.
//

import UIKit

struct FeatureManager {
    static let dataFromPlist = {() -> NSDictionary? in
        let featureDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "FeatureManager", ofType: "plist")!)
        return featureDictionary
    }()
    
    // MARK: - Feature methods
    static func hasNoMedication() -> Bool {
        if let featureDictionary = dataFromPlist, (featureDictionary["NoMedication"] as? Bool) == true {
            return true
        }
        return false
    }
    static func showErrorScreen() -> Bool {
        if let featureDictionary = dataFromPlist, (featureDictionary["showErrorScreen"] as? Bool) == true {
            return true
        }
        return false
    }
    static func hasAllMedication() -> Bool {
        if let featureDictionary = dataFromPlist, (featureDictionary["AllMedication"] as? Bool) == true {
            return true
        }
        return false
    }
    
}
