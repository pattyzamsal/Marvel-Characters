//
//  CharacterDetailProvider.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Domain
import Foundation

public class CharacterDetailProvider {
    private let apiClient: APIClient
    
    public init() {
        apiClient = APIClient()
    }
}

extension CharacterDetailProvider: CharacterDetailProviderContract {
    public func getCharacterDetailBy(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void) {
        apiClient.execute(endpoint: .getDetailCharacter(id: id)) { (response: WebServiceResponse<CharactersEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain(),
                  let character = model.data.results.first else {
                if case .failure(let error) = response,
                   let webError = error as? WebServiceProtocolError,
                   let message = webError.errorDescription {
                    completion(.failure(CharacterDetailProviderContractError.generic(error: message)))
                }
                return
            }
            completion(.success(character))
        }
    }
}
