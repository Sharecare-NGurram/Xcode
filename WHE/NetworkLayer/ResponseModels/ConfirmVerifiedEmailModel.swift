//
//  ConfirmVerifiedEmailModel.swift
//  WHE
//
//  Created by Pratima Pundalik on 03/04/23.
//

import Foundation
struct ConfirmVerifiedEmailModel {
    var email: [EmailConfirmData] = []
}
struct EmailConfirmData {
    var isMfaValidated: Bool?
    var isPrimary: Bool?
}
