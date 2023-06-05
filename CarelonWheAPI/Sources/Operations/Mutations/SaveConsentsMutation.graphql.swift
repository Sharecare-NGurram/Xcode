// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SaveConsentsMutation: GraphQLMutation {
  public static let operationName: String = "SaveConsentsMutation"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation SaveConsentsMutation($consentsToSend: [ConsentV2Request_Input]) {
        addConsents(input: {consents: $consentsToSend}) {
          __typename
          status
          message
        }
      }
      """#
    ))

  public var consentsToSend: GraphQLNullable<[ConsentV2Request_Input?]>

  public init(consentsToSend: GraphQLNullable<[ConsentV2Request_Input?]>) {
    self.consentsToSend = consentsToSend
  }

  public var __variables: Variables? { ["consentsToSend": consentsToSend] }

  public struct Data: CarelonWheAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("addConsents", AddConsents?.self, arguments: ["input": ["consents": .variable("consentsToSend")]]),
    ] }

    /// Save the member's consent choices.
    public var addConsents: AddConsents? { __data["addConsents"] }

    /// AddConsents
    ///
    /// Parent Type: `ConsentWriteResponse`
    public struct AddConsents: CarelonWheAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.ConsentWriteResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("status", String?.self),
        .field("message", String?.self),
      ] }

      public var status: String? { __data["status"] }
      public var message: String? { __data["message"] }
    }
  }
}
