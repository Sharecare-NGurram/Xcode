// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EmailValidationMutation: GraphQLMutation {
  public static let operationName: String = "EmailValidation"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation EmailValidation($emailInput: mutationInput_post_xpocare_v1_user_validateEmail_input_contactInfo_Input!) {
        validateEmail(input: {contactInfo: $emailInput}) {
          __typename
          token
          pingRiskId
          pingUserId
          pingDeviceId
        }
      }
      """#
    ))

  public var emailInput: MutationInput_post_xpocare_v1_user_validateEmail_input_contactInfo_Input

  public init(emailInput: MutationInput_post_xpocare_v1_user_validateEmail_input_contactInfo_Input) {
    self.emailInput = emailInput
  }

  public var __variables: Variables? { ["emailInput": emailInput] }

  public struct Data: CarelonWheAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("validateEmail", ValidateEmail?.self, arguments: ["input": ["contactInfo": .variable("emailInput")]]),
    ] }

    /// Send a one-time-pin to the email address the member want to claim as their primary email address.
    public var validateEmail: ValidateEmail? { __data["validateEmail"] }

    /// ValidateEmail
    ///
    /// Parent Type: `ClaimEmailPayload`
    public struct ValidateEmail: CarelonWheAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.ClaimEmailPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("token", String.self),
        .field("pingRiskId", String.self),
        .field("pingUserId", String.self),
        .field("pingDeviceId", String.self),
      ] }

      public var token: String { __data["token"] }
      public var pingRiskId: String { __data["pingRiskId"] }
      public var pingUserId: String { __data["pingUserId"] }
      public var pingDeviceId: String { __data["pingDeviceId"] }
    }
  }
}
