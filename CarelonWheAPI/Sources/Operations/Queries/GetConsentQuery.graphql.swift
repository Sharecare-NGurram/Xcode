// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetConsentQuery: GraphQLQuery {
  public static let operationName: String = "GetConsentQuery"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query GetConsentQuery {
        needConsent(Accept_Language: "EN") {
          __typename
          content
          contentId
          created
          languageCode
          source
          version
          type
          tenantId
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
      .field("needConsent", [NeedConsent?]?.self, arguments: ["Accept_Language": "EN"]),
    ] }

    /// Retrieve all consent content that still needs member agreement
    public var needConsent: [NeedConsent?]? { __data["needConsent"] }

    /// NeedConsent
    ///
    /// Parent Type: `ContentV2Response`
    public struct NeedConsent: CarelonWheAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.ContentV2Response }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("content", String?.self),
        .field("contentId", String?.self),
        .field("created", CarelonWheAPI.DateTime?.self),
        .field("languageCode", String?.self),
        .field("source", String?.self),
        .field("version", Int?.self),
        .field("type", GraphQLEnum<CarelonWheAPI.Query_getContentV3_items_type>?.self),
        .field("tenantId", String?.self),
      ] }

      public var content: String? { __data["content"] }
      public var contentId: String? { __data["contentId"] }
      public var created: CarelonWheAPI.DateTime? { __data["created"] }
      public var languageCode: String? { __data["languageCode"] }
      public var source: String? { __data["source"] }
      public var version: Int? { __data["version"] }
      public var type: GraphQLEnum<CarelonWheAPI.Query_getContentV3_items_type>? { __data["type"] }
      public var tenantId: String? { __data["tenantId"] }
    }
  }
}
