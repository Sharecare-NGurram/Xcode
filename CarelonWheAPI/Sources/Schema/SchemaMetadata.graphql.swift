// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == CarelonWheAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == CarelonWheAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == CarelonWheAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == CarelonWheAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Mutation": return CarelonWheAPI.Objects.Mutation
    case "ClaimEmailPayload": return CarelonWheAPI.Objects.ClaimEmailPayload
    case "Query": return CarelonWheAPI.Objects.Query
    case "ContentV2Response": return CarelonWheAPI.Objects.ContentV2Response
    case "ProfileServicesV2DTO": return CarelonWheAPI.Objects.ProfileServicesV2DTO
    case "XpoProfileDTO": return CarelonWheAPI.Objects.XpoProfileDTO
    case "ContactInfo": return CarelonWheAPI.Objects.ContactInfo
    case "AnthemAuthConfig": return CarelonWheAPI.Objects.AnthemAuthConfig
    case "query_anthem_auth_config_auth_tokens": return CarelonWheAPI.Objects.Query_anthem_auth_config_auth_tokens
    case "query_anthem_auth_config_auth_tokens_query_param": return CarelonWheAPI.Objects.Query_anthem_auth_config_auth_tokens_query_param
    case "ConsentWriteResponse": return CarelonWheAPI.Objects.ConsentWriteResponse
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
