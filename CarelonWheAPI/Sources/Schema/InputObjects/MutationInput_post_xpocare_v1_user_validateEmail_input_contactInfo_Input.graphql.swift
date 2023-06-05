// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct MutationInput_post_xpocare_v1_user_validateEmail_input_contactInfo_Input: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    channel: GraphQLEnum<Email_const>,
    value: String
  ) {
    __data = InputDict([
      "channel": channel,
      "value": value
    ])
  }

  public var channel: GraphQLEnum<Email_const> {
    get { __data["channel"] }
    set { __data["channel"] = newValue }
  }

  /// The email address to be claimed
  public var value: String {
    get { __data["value"] }
    set { __data["value"] = newValue }
  }
}
