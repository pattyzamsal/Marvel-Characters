//
//  MockCharactersProvider.swift
//  DataTests
//
//  Created by Patricia Zambrano on 09/04/21.
//

import Foundation
@testable import Data
@testable import Domain

enum MockCharactersProviderContractError: Error {
    case generic
}

class MockCharactersProvider {
    private let mockApiClient: MockAPIClient
    
    init(result: Result<Data, Error>) {
        mockApiClient = MockAPIClient(result: result)
    }
    
    func getListCharacters(page: Int, completion: @escaping (Result<DataCharacters, Error>) -> Void) {
        mockApiClient.execute(endpoint: .getListCharacters(page: page)) { (response: WebServiceResponse<CharactersEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain() else {
                completion(.failure(MockCharactersProviderContractError.generic))
                return
            }
            completion(.success(model.data))
        }
    }
}
