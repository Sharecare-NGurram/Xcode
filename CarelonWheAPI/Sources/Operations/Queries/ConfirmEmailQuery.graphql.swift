// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConfirmEmailQuery: GraphQLQuery {
  public static let operationName: String = "ConfirmEmailQuery"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query ConfirmEmailQuery {
        xpoProfile {
          __typename
          userProfile {
            __typename
            email {
              __typename
              isMfaValidated
              isPrimary
            }
          }
        }
      }
      """#
    ))

  public init() {}

  public struct Data: CarelonWheAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("xpoProfile", XpoProfile?.self),
    ] }

    public var xpoProfile: XpoProfile? { __data["xpoProfile"] }

    /// XpoProfile
    ///
    /// Parent Type: `ProfileServicesV2DTO`
    public struct XpoProfile: CarelonWheAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.ProfileServicesV2DTO }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("userProfile", UserProfile?.self),
      ] }

      /// Profile Information of the user
      public var userProfile: UserProfile? { __data["userProfile"] }

      /// XpoProfile.UserProfile
      ///
      /// Parent Type: `XpoProfileDTO`
      public struct UserProfile: CarelonWheAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.XpoProfileDTO }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("email", [Email]?.self),
        ] }

        public var email: [Email]? { __data["email"] }

        /// XpoProfile.UserProfile.Email
        ///
        /// Parent Type: `ContactInfo`
        public struct Email: CarelonWheAPI.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.ContactInfo }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("isMfaValidated", Bool?.self),
            .field("isPrimary", Bool?.self),
          ] }

          public var isMfaValidated: Bool? { __data["isMfaValidated"] }
          public var isPrimary: Bool? { __data["isPrimary"] }
        }
      }
    }
  }
}
