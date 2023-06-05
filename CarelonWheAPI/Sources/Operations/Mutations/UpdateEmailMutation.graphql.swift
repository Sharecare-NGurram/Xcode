// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateEmailMutation: GraphQLMutation {
  public static let operationName: String = "UpdateEmail"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation UpdateEmail($otp: String!, $token: String!, $pingDeviceId: String!, $pingUserId: String!, $pingRiskId: String!) {
        updateEmail(
          input: {otp: $otp, token: $token, pingRiskId: $pingRiskId, pingUserId: $pingUserId, pingDeviceId: $pingDeviceId}
        )
      }
      """#
    ))

  public var otp: String
  public var token: String
  public var pingDeviceId: String
  public var pingUserId: String
  public var pingRiskId: String

  public init(
    otp: String,
    token: String,
    pingDeviceId: String,
    pingUserId: String,
    pingRiskId: String
  ) {
    self.otp = otp
    self.token = token
    self.pingDeviceId = pingDeviceId
    self.pingUserId = pingUserId
    self.pingRiskId = pingRiskId
  }

  public var __variables: Variables? { [
    "otp": otp,
    "token": token,
    "pingDeviceId": pingDeviceId,
    "pingUserId": pingUserId,
    "pingRiskId": pingRiskId
  ] }

  public struct Data: CarelonWheAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateEmail", CarelonWheAPI.JSON?.self, arguments: ["input": [
        "otp": .variable("otp"),
        "token": .variable("token"),
        "pingRiskId": .variable("pingRiskId"),
        "pingUserId": .variable("pingUserId"),
        "pingDeviceId": .variable("pingDeviceId")
      ]]),
    ] }

    /// Send a one-time-pin to the email address the member want to claim as their primary email address.
    public var updateEmail: CarelonWheAPI.JSON? { __data["updateEmail"] }
  }
}
