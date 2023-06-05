//
//  ConfigViewModel.swift
//  WHE
//
//  Created by Rajesh Gaddam on 17/04/23.
//

import Foundation

class ConfigViewModel {
    let envTitles = ["dev", "sit","uat"]
    let envURLTitles = ["https://web.dev1.wholehealth.caremarket.ai/api/gateway/graphql","https://web.sit1.wholehealth.caremarket.ai/api/gateway/graphql","https://web.stg.wholehealth.caremarket.ai/api/gateway/graphql"]
}


enum AppEnvironment: String, CaseIterable {
    case localhost
    case dev
    case sit
    case uat
    case prod
    
    func endpoint() -> String {
        switch self {
        case .localhost:
            return "http://localhost:8080/api/gateway/graphql"
        case .dev:
            return "https://web.dev1.wholehealth.caremarket.ai/api/gateway/graphql"
        case .sit:
            return "https://web.sit1.wholehealth.caremarket.ai/api/gateway/graphql"
        case .uat:
            return "https://web.stg.wholehealth.caremarket.ai/api/gateway/graphql"
        case .prod:
            return "https://web.wholehealth.caremarket.ai/api/gateway/graphql"
        }
    }
}
