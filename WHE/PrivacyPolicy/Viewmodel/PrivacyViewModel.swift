//
//  PrivacyViewModel.swift
//  WHE
//
//  Created by Rajesh Gaddam on 03/03/23.
//

import Foundation

class PrivacyViewModel {
    
    let consentTitle = "I Consent"
    let privacyTitle = "I Agree"
    let privacyHeight = 22.0
    
    func loadHTMLStringForPrivacyPolicy() -> String {
        if let needConsent = ApolloClientManager.shared.needConsentDict, let consentType =   needConsent[ConsentType.privacy] {
            let privacyPolicy = consentType
            return privacyPolicy
        } else {
            return ""
        }
    }
    
    func loadHTMLForEarlyAccess() -> String {
        if let needConsent = ApolloClientManager.shared.needConsentDict, let consentType =   needConsent[ConsentType.earlyAccess] {
            let earlyAccess = consentType
            return earlyAccess
        } else {
            return ""
        }
    }
}
