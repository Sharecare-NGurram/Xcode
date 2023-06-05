// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// Client Specific
public struct ClientSpecifics_Input: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    key: GraphQLNullable<String> = nil,
    value: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "key": key,
      "value": value
    ])
  }

  public var key: GraphQLNullable<String> {
    get { __data["key"] }
    set { __data["key"] = newValue }
  }

  public var value: GraphQLNullable<String> {
    get { __data["value"] }
    set { __data["value"] = newValue }
  }
}
