//
//  ConfirmEmailPickFocuseAreaViewModel.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 03/03/23.
//

import UIKit

class ConfirmEmailPickFocuseAreaViewModel: NSObject {

  var listOfConfirmEmail = ["Let’s make sure your information is up to date.", "Select one or two things to focus on and start earning rewards."]
  let listOfHeaderText = ["Confirm email", "Pick a focus area"]
  let listButtonTitle = ["Confirm", "Pick"]
  
  func fetchNumberOfCellDisplay() -> Int {
    return listOfConfirmEmail.count
  }
}
