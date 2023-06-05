// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ConsentV2Request_Input: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    consent: GraphQLEnum<MutationInput_submitConsentV2_input_consents_items_consent>?,
    version: Int,
    languageCode: String?,
    type: GraphQLEnum<MutationInput_submitConsentV2_input_consents_items_type>,
    contentId: String,
    clientSpecifics: GraphQLNullable<[ClientSpecifics_Input?]> = nil
  ) {
    __data = InputDict([
      "consent": consent,
      "version": version,
      "languageCode": languageCode,
      "type": type,
      "contentId": contentId,
      "clientSpecifics": clientSpecifics
    ])
  }

  public var consent: GraphQLEnum<MutationInput_submitConsentV2_input_consents_items_consent>? {
    get { __data["consent"] }
    set { __data["consent"] = newValue }
  }

  public var version: Int {
    get { __data["version"] }
    set { __data["version"] = newValue }
  }

  public var languageCode: String? {
    get { __data["languageCode"] }
    set { __data["languageCode"] = newValue }
  }

  public var type: GraphQLEnum<MutationInput_submitConsentV2_input_consents_items_type> {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }

  public var contentId: String {
    get { __data["contentId"] }
    set { __data["contentId"] = newValue }
  }

  public var clientSpecifics: GraphQLNullable<[ClientSpecifics_Input?]> {
    get { __data["clientSpecifics"] }
    set { __data["clientSpecifics"] = newValue }
  }
}
