//
//  TokenInterceptor.swift
//  WHE
//
//  Created by Pratima Pundalik on 01/03/23.
//
import Apollo
import ApolloAPI

class TokenInterceptor: ApolloInterceptor {
    
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
            request.addHeader(name: "Authorization", value: token)
            print(request.additionalHeaders)
            chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
}
