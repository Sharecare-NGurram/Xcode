//
//  FocusAreaViewModel.swift
//  WHE
//
//  Created by Rajesh Gaddam on 24/03/23.
//

import Foundation

class FocusAreaViewModel {
     let getFocusAreaArray = ["We’ll help you keep track with daily check ins.","We’ll ask you to walk at least a certain number of steps a day."]
    let getDescriptionAreaArray = ["I want to track meds","I want to be active"]
    let listImages = ["trackMeds", "Active"]
    let imagesHKit = "dontAllow"
    let walkHKitImg = "walk"
    let sharingDeniedText = "Didn’t allow access to data"
    let sharingAuthorizedText = "Ready to earn rewards"
    let sharingNotDeterminedText = "Earn rewards"
    let rewardsImg = "FocusArea"
    let checkMarkImg = "check_circle"
    let continueButtonTitle = "Continue"
}

struct ImportMedsViewModel {
    let dailyReminders = " Set daily reminders"
    let medsNotes = " Add notes about your meds "
    let prescription = " See prescription details"
    let importMeds = "Import Your Meds"
    let importMedsDescription = "We can import your meds based on your claims data, to help you better keep track of them."
    let byImport = "By importing you can:"
    
}
