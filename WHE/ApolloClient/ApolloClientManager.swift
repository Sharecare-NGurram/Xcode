//
//  ApolloClientManager.swift
//  WHE
//
//  Created by Pratima Pundalik on 02/03/23.
//

import Apollo
import CarelonWheAPI
import UIKit

enum ClientError: Error {
    case invalidResponse
    case invalidParameters
    case invalidClient
}

class ApolloClientManager {
    static let shared = ApolloClientManager()
    var needConsentArray : [ConsentData]?
    var needConsentDict :[ConsentType : String]?
    var contentIds: [String : String]?
    var accessToken: String = "" {
        didSet {
            LocalStorageManager.setAccessToken(token: accessToken)
            loadClient(environment: self.currentEnvironment, token: accessToken)
        }
    }
    var refreshToken: String = ""
    var tokenExpirationSeconds = 0.0
    
    private(set) var currentEnvironment: AppEnvironment = .localhost
    
    private var apolloClient: ApolloClient?
    @discardableResult public func loadClient(environment: AppEnvironment, token: String) -> Bool {
        guard let endpointURL =  URL(string: environment.endpoint()) else {
            debugPrint("Unable to load endpoint URL!!!")
            return false
        }
        let store = ApolloStore()
        let interceptorProvider = NetworkInterceptorProvider(
            interceptors: [TokenInterceptor(token: token)],
            store: store
        )
        let networkTransport = RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider, endpointURL: endpointURL
        )
        apolloClient = ApolloClient(networkTransport: networkTransport, store: store)
        currentEnvironment = environment
        LocalStorageManager.setCheckEnvironment(environment: environment.rawValue)
        return true
    }
    
    public func loginUrlString() -> String {
        return currentEnvironment.rawValue + "/anthem/login"
    }
    
    private init(){
        let envVar = LocalStorageManager.fetchCheckEnvironment()
        if let current = AppEnvironment(rawValue: envVar) {
            currentEnvironment = current
            loadClient(environment: currentEnvironment, token: "")
        } else  {
            loadClient(environment: .localhost, token: "")
            currentEnvironment = .localhost
        }
    }
    func fetchLoginDetails(completion: @escaping (Result<LoginResponseModel, Error>)-> Void) {
        guard let apolloClient else {
             debugPrint("Unable to load network client!!!")
            completion(.failure(ClientError.invalidClient))
            return
        }
        apolloClient.fetch(query: LoginQuery()) { result in
            guard let data = try? result.get().data else { return }
            debugPrint(data.anthem_auth_config?.login_url ?? "data not found?")
            debugPrint(data)
            if let LoginUrl = data.anthem_auth_config?.login_url {
                var loginResponse = LoginResponseModel()
                loginResponse.login_url = LoginUrl
                loginResponse.access_token = data.anthem_auth_config?.auth_tokens?.query_param?.access_token
                loginResponse.expiration_seconds = data.anthem_auth_config?.auth_tokens?.query_param?.expiration_seconds
                loginResponse.refresh_token = data.anthem_auth_config?.auth_tokens?.query_param?.refresh_token
                loginResponse.url_base = data.anthem_auth_config?.auth_tokens?.url_base
                
                completion(.success(loginResponse))
                return
            }
            completion(.failure(ClientError.invalidResponse))
        }
    }
    
    func getConsentDetails(completion: @escaping (Result<[ConsentData], Error>)-> Void) {
        guard let apolloClient else {
             debugPrint("Unable to load network client!!!")
            completion(.failure(ClientError.invalidClient))
            return
        }

        apolloClient.fetch(query: GetConsentQuery()) { result in
            switch result {
            case .success(_):
                guard let data = try? result.get().data,
                      let needConsent = data.needConsent else { return }
                var consentResponseModel = ConsentResponseModel()
                var consentModel = ConsentData()
                var needConsentArray = [ConsentData]()
                for consent in needConsent {
                    consentModel.consentType = ConsentType(rawValue: consent?.type?.rawValue ?? "")
                    consentModel.contentId = consent?.contentId
                    consentModel.htmlContent = consent?.content
                    consentModel.version = consent?.version
                    needConsentArray.append(consentModel)

                    if let consentType = consentModel.consentType {
                        let consentTypeValue = consentType.rawValue
                        consentResponseModel.consentValue[consentType] = consentModel.htmlContent
                        consentResponseModel.contentIDs[consentTypeValue] = consentModel.contentId
                    }
                }
                self.contentIds = consentResponseModel.contentIDs
                self.needConsentArray = needConsentArray
                consentResponseModel.needConsents = needConsentArray
                self.needConsentDict = consentResponseModel.consentValue
                completion(.success(needConsentArray))

            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(ClientError.invalidParameters))
            }
        }
    }
    
    func getEmailConfirmation(completion: @escaping (Result<Bool, Error>)-> Void) {
        guard let apolloClient else {
             debugPrint("Unable to load network client!!!")
            completion(.failure(ClientError.invalidClient))
            return
        }
        apolloClient.fetch(query: ConfirmEmailQuery()) { result in
            guard let data = try? result.get().data, let confirmedEmail = data.xpoProfile?.userProfile?.email else { return }
            var confirmVerifiedModel = ConfirmVerifiedEmailModel()
            completion(.success(true))
        
        }
            completion(.failure(ClientError.invalidResponse))
        }

    func updateEmail(otp:String, token : String, pingDeviceId : String, pingUserId :String,  pingRiskId : String, saveCompletion: @escaping (Result<Bool, Error>) -> Void) {
        guard let apolloClient else {
             debugPrint("Unable to load network client!!!")
            saveCompletion(.failure(ClientError.invalidClient))
            return
        }
        apolloClient.perform(mutation: UpdateEmailMutation(otp: otp, token: token, pingDeviceId: pingDeviceId, pingUserId: pingUserId, pingRiskId: pingRiskId)){
            result in
            print(result)
           switch result {
           case .success (let graphqlResult):
                if let data = graphqlResult.data, let updateEmailData = data.updateEmail{
                    print("success")
                    var updateEmailModel = UpdateEmailModel()
                    updateEmailModel.updateEmailID = updateEmailData
                    saveCompletion(.success(true))
                }
                if let errors = graphqlResult.errors, !errors.isEmpty {
                    print("GraphQL errors:")
                    errors.forEach {
                        print($0.localizedDescription)
                    }
                    saveCompletion(.failure(ClientError.invalidResponse))
                }
            case .failure(let error):
               debugPrint(error.localizedDescription)
               saveCompletion(.success(true))
            }
        }
    }

    func validateEmail(emailAddress:String, saveCompletion: @escaping (Result<ValidateEmailModel, Error>) -> Void) {
        let validateEmailInput  = InputDict([
            "channel": Email_const.email,
            "value": emailAddress])
        let otp_const = MutationInput_post_xpocare_v1_user_validateEmail_input_contactInfo_Input(validateEmailInput)
        guard let apolloClient else {
             debugPrint("Unable to load network client!!!")
            saveCompletion(.failure(ClientError.invalidClient))
            return
        }
        apolloClient.perform(mutation:EmailValidationMutation(emailInput: otp_const) ){
            result in
            print(result)
            switch result {
            case .success (let graphqlResult):
                if let data = graphqlResult.data, let validateEmailData = data.validateEmail{
                    print("success")
                    var validateEmailModel = ValidateEmailModel()
                    validateEmailModel.pingRiskId = validateEmailData.pingRiskId
                    validateEmailModel.pingDeviceId = validateEmailData.pingDeviceId
                    validateEmailModel.pingUserId = validateEmailData.pingUserId
                    validateEmailModel.token = validateEmailData.token
                    saveCompletion(.success(validateEmailModel))
                }
                if let errors = graphqlResult.errors, !errors.isEmpty {
                    print("GraphQL errors:")
                    errors.forEach {
                        print($0.localizedDescription)
                    }
                    saveCompletion(.failure(ClientError.invalidResponse))
                }
            case .failure(let error):
               debugPrint(error.localizedDescription)
               saveCompletion(.failure(ClientError.invalidParameters))
            }
        }
    }



    func saveAgreementForConsents(type: ConsentType, completion: @escaping (Result<Bool, Error>) -> Void) {

        guard let consentList = ApolloClientManager.shared.needConsentArray else {
            return completion(.failure(ClientError.invalidParameters))
        }
        
        let consent = consentList.filter { consentData in
            if type == consentData.consentType {
                return true
            }
            return false
        }.first
        
        var consentType: MutationInput_submitConsentV2_input_consents_items_type = .earlyAccess
        switch type {
        case .earlyAccess:
            consentType = .earlyAccess
        case .privacy:
            consentType = .privacy
        }
        
        if let consentId = consent?.contentId,
           let version = consent?.version {
            saveConsents(consentID:consentId,
                         version: version,
                         type: consentType,
                         saveCompletion: completion)
            return
        }
        return completion(.failure(ClientError.invalidParameters))
    }
    
    func saveConsents(consentID : String,
                      version: Int,
                      type: MutationInput_submitConsentV2_input_consents_items_type,
                      saveCompletion: @escaping (Result<Bool, Error>) -> Void) {
        let consentInput  = InputDict([
            "consent": MutationInput_submitConsentV2_input_consents_items_consent.yes,
            "languageCode": "en",
                    "type": type,
            "contentId": consentID,
            "version": version
        ])
        let consentRequest = ConsentV2Request_Input(consentInput)
        guard let apolloClient else {
             debugPrint("Unable to load network client!!!")
            saveCompletion(.failure(ClientError.invalidClient))
            return
        }
        apolloClient.perform(mutation: SaveConsentsMutation(consentsToSend: [consentRequest])){
            result in
            switch result {
            case .success (let graphqlResult):
                if let data = graphqlResult.data, let addConsent = data.addConsents{
                    debugPrint("success")
                    var saveModel = SaveConsentModel()
                    saveModel.isConsentSaved = addConsent.status
                    saveModel.saveConsentMessage = addConsent.message
                    saveCompletion(.success(true))
                    return
                }
                if let errors = graphqlResult.errors, !errors.isEmpty {
                    debugPrint("GraphQL errors:")
                    errors.forEach {
                        debugPrint($0.localizedDescription)
                    }
                    saveCompletion(.failure(ClientError.invalidResponse))
                    return
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                saveCompletion(.failure(ClientError.invalidParameters))
            }
        }
    }

}

