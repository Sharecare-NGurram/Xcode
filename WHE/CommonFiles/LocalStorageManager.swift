//
//  LocalStorageManager.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 27/02/23.
//
//UserDefultsStoredInformation
import Foundation

private enum LocalStoredKey: String {

    case FTUELetGetStarted = "LetsGetStarted"
    case kAccessToken = "savedToken"
    case FTUELetsGo = "LetsGo"
    case kConfirmEmail = "confirmEmail"
    case trackMedicines = "MedicineSaved"
    case trackMedicinesNotRightNow = "MedicaneNotRightNow"
    case checkEnvironment = "CheckEnvironment"
    case editWeeklyPlanOnBoarding = "editWeeklyPlanOnBoard"
    case trackYourMeds = "TrackYourMeds"
    case trackYourSteps = "TrackYourSteps"
    case trackYourMedsTaken = "TrackYourMedsTaken"
    case trackYourStepsDone = "TrackYourStepsDone"
    case dailyCheckIn = "dailyCheckIn"
    case willDoLaterChckIn = "willDoLaterChckIn"
    case newPrescriptionAdd = "NewPrescriptionAdded"
    case skipCheckin = "SkipCheckin"
    case checkinTime = "checkinTime"
}

class LocalStorageManager {
    static let defaults = UserDefaults.standard

    //Dev Environment
    class func setCheckEnvironment(environment: String) {
        defaults.set(environment, forKey: LocalStoredKey.checkEnvironment.rawValue)
    }
    
    // fetch Value
    class func fetchCheckEnvironment() -> String  {
        return defaults.string(forKey: LocalStoredKey.checkEnvironment.rawValue) ?? ""
    }
    
    // set value for GetStarted Screen
    class func setLetsGetStarted(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.FTUELetGetStarted.rawValue)
    }
    
    // fetch Value
    class func fetchLetsGetStarted() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.FTUELetGetStarted.rawValue)
    }
    
    //set value
    class func setSkipCheckin(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.skipCheckin.rawValue)
    }
    
    // fetch Value
    class func fetchSkipCheckin() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.skipCheckin.rawValue)
    }
    
    class func setCheckinTime(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.checkinTime.rawValue)
    }
    
    // fetch Value
    class func fetchCheckinTime() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.checkinTime.rawValue)
    }
    
    class func setMedicineSaved(status: Bool) {
         defaults.set(status, forKey: LocalStoredKey.trackMedicines.rawValue)
     }
     
    class func fetchMedicineSaved() -> Bool {
          defaults.bool(forKey: LocalStoredKey.trackMedicines.rawValue)
     }
    
    class func setAccessToken(token: String) {
        defaults.set(token, forKey: LocalStoredKey.kAccessToken.rawValue)
    }
    
    class func fetchAccessToken() -> String {
        return defaults.string(forKey: LocalStoredKey.kAccessToken.rawValue) ?? "123"
    }
    
    class func setLetsGo(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.FTUELetsGo.rawValue)
    }
    
    class func fetchLetsGo() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.FTUELetsGo.rawValue)
    }
    
    class func setConfirmEmail(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.kConfirmEmail.rawValue)
    }
    
    class func fetchConfirmEmail() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.kConfirmEmail.rawValue)
    }
  
    class func setTrackMedicinesNotRightNow(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.trackMedicinesNotRightNow.rawValue)
    }

    class func fetchTrackMedicinesNotRightNow() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.trackMedicinesNotRightNow.rawValue)
    }
  
    class func fetchEditWeeklyPlanOnBoarding() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.editWeeklyPlanOnBoarding.rawValue)
    }
   
    class func setEditWeeklyPlanOnBoarding(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.editWeeklyPlanOnBoarding.rawValue)
    }    
    class func setTrackYourMeds(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.trackYourMeds.rawValue)
    }

    class func fetchTrackYourMeds() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.trackYourMeds.rawValue)
    }
    class func setTrackYourSteps(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.trackYourSteps.rawValue)
    }

    class func fetchTrackYourSteps() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.trackYourSteps.rawValue)
    }
    
    class func setTrackYourMedsTaken(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.trackYourMedsTaken.rawValue)
    }

    class func fetchTrackYourMedsTaken() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.trackYourMedsTaken.rawValue)
    }
    class func setTrackYourStepsDone(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.trackYourStepsDone.rawValue)
    }

    class func fetchTrackYourStepsDone() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.trackYourStepsDone.rawValue)
    }
    class func fetchWillDoLaterChckIn() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.willDoLaterChckIn.rawValue)
    }

    class func setWillDoLaterChckIn(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.willDoLaterChckIn.rawValue)
    }

    class func fetchDailyCheckIn() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.dailyCheckIn.rawValue)
    }

    class func setDailyCheckIn(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.dailyCheckIn.rawValue)
    }
  
    class func fetchMedsNewPrescription() -> Bool {
        return defaults.bool(forKey: LocalStoredKey.newPrescriptionAdd.rawValue)
    }

    class func setMedsNewPrescription(status: Bool) {
        defaults.set(status, forKey: LocalStoredKey.newPrescriptionAdd.rawValue)
    }
}


