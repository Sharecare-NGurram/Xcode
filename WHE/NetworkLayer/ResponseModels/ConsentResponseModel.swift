//
//  ConsentResponseModel.swift
//  WHE
//
//  Created by Pratima Pundalik on 28/02/23.
//

import Foundation

struct ConsentResponseModel {
    var needConsents: [ConsentData] = []
    var consentValue: [ConsentType: String] = [:]
    var contentIDs: [String: String] = [:]
}

struct ConsentData {
    var htmlContent: String?
    var contentId: String?
    var consentType: ConsentType?
    var version: Int?
}

struct UpdateEmail {
    var updateEmailId: String?
}

struct EmailValidation {
    var pingDeviceId: String?
    var pingRiskId: String?
    var pingUserId: String?
    var token : String?
}

enum ConsentType: String {
    case earlyAccess = "EARLY_ACCESS"
    case privacy = "PRIVACY"
}


