// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LoginQuery: GraphQLQuery {
  public static let operationName: String = "LoginQuery"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query LoginQuery {
        anthem_auth_config {
          __typename
          login_url
          auth_tokens {
            __typename
            url_base
            query_param {
              __typename
              access_token
              expiration_seconds
              refresh_token
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
      .field("anthem_auth_config", Anthem_auth_config?.self),
    ] }

    /// This is the Anthem login configuration. The login_url should be used to show the Anthem login screens. 
    /// The auth_tokens object is has the 'response' that we should be listening for. The url_base is the
    /// URL that indicates a login is complete, and the tokens are in the query parameters specified in the
    /// query_param attributes.
    public var anthem_auth_config: Anthem_auth_config? { __data["anthem_auth_config"] }

    /// Anthem_auth_config
    ///
    /// Parent Type: `AnthemAuthConfig`
    public struct Anthem_auth_config: CarelonWheAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.AnthemAuthConfig }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("login_url", CarelonWheAPI.URL?.self),
        .field("auth_tokens", Auth_tokens?.self),
      ] }

      public var login_url: CarelonWheAPI.URL? { __data["login_url"] }
      public var auth_tokens: Auth_tokens? { __data["auth_tokens"] }

      /// Anthem_auth_config.Auth_tokens
      ///
      /// Parent Type: `Query_anthem_auth_config_auth_tokens`
      public struct Auth_tokens: CarelonWheAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.Query_anthem_auth_config_auth_tokens }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("url_base", CarelonWheAPI.URL?.self),
          .field("query_param", Query_param?.self),
        ] }

        public var url_base: CarelonWheAPI.URL? { __data["url_base"] }
        public var query_param: Query_param? { __data["query_param"] }

        /// Anthem_auth_config.Auth_tokens.Query_param
        ///
        /// Parent Type: `Query_anthem_auth_config_auth_tokens_query_param`
        public struct Query_param: CarelonWheAPI.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { CarelonWheAPI.Objects.Query_anthem_auth_config_auth_tokens_query_param }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("access_token", String?.self),
            .field("expiration_seconds", String?.self),
            .field("refresh_token", String?.self),
          ] }

          public var access_token: String? { __data["access_token"] }
          public var expiration_seconds: String? { __data["expiration_seconds"] }
          public var refresh_token: String? { __data["refresh_token"] }
        }
      }
    }
  }
}
