//
//  MockCharacterDetailProvider.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 09/04/21.
//

import Foundation
@testable import Data
@testable import Domain

enum MockCharacterDetailProviderContractError: Error {
    case generic
}

class MockCharacterDetailProvider {
    private let mockApiClient: MockAPIClient
    
    init(result: Result<Data, Error>) {
        mockApiClient = MockAPIClient(result: result)
    }
    
    func getCharacterDetailBy(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void) {
        mockApiClient.execute(endpoint: .getDetailCharacter(id: id)) { (response: WebServiceResponse<CharactersEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain(),
                  let character = model.data.results.first else {
                completion(.failure(MockCharacterDetailProviderContractError.generic))
                return
            }
            completion(.success(character))
        }
    }
}
