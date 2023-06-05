//
//  ConfirmEmailAddressViewModel.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 10/03/23.
//

import UIKit

class ConfirmEmailAddressViewModel: NSObject {
let emptyEmailButtonTitle = "Enter Email Address"
let validEmailButtonTitle = "Send Email Verification"
  
  
  // MARK: - Email Validation formate
  func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}
