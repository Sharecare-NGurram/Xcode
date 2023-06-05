//
//  YourWeeklyPlanViewModel.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 06/04/23.
//

import UIKit

class YourWeeklyPlanViewModel {

  let headerLineHeight = 1.05
  let descriptionLineHeight = 1.32
  let healthAccessURL = "App-prefs:Privacy&path=HEALTH"
  let sharingDeniedSteps = "You haven’t allowed us access to your health data, so we’re unable to track your progress towards your step count."
  let sharingAuthorizedSteps = "We’ve set up 5,000 steps as your target step count based on your activity for the past 30 days."
  
  let sharingAuthorizedMeds = "Get a better understanding of your meds usage by tracking your medications daily."
  let sharingSkippedMeds = "You’ll still earn rewards tracking your medications but by adding meds you’ll get better insights on med usage."
  
  let setupMyfirstWeekCheckIn =  "We’ll check in with you at 7:00 PM each day."
  let skipBonusDoLaterCheckIn = "We can help keep your progress on track by giving you a gentle nudge at a time you prefer each day."
  let setUpCheckInButton = "Change Check In Time"
  let skipCheckInButton = "Choose a Check In Time"
  let footerBGImage = "for_you_header_background"
  let gotoSettingLinkImg = "external_link"
  let connecttoHealthAppText = "Connect to Health App"
  let goToHealthSettingsText = "Go to Health Settings"
  let radioButtonTickMarkImage = "check_circle"
  let radioButtonUnTickMarkImage = "unCheckMark"
  let sharingDeniedStepsTag = 0
  let sharingNotDeterminedStepsTag = 1
}
