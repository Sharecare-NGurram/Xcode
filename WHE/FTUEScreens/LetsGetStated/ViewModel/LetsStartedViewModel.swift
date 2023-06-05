//
//  LetsStartedViewModel.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 24/02/23.
//

import Foundation

class LetsStartedViewModel: NSObject {
  let getStartIndexArray = ["Form healthy habits with tools like a short list to keep your weeks on track", "Earn real money just by doing what you already do", "Enjoy the perks of other bonus offers", "Cash out your rewards to a Visa gift card"]
  let imagviewHeightIndex = [122, 98, 98, 98]
  let listImages = ["Yoga", "2ndImage", "3rdImage", "4thImage"]
  let onBoardingImages = ["onboarding1", "onboarding2", "onboarding3", "onboarding4"]
  
  func getTableviewCellCount() -> Int {
    return getStartIndexArray.count
  }
}
