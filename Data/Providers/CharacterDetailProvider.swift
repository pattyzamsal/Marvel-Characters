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
    public func getCharacterDetail(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void) {
        if apiClient.validateConnectInternet() {
            apiClient.execute(endpoint: .getDetailCharacter(id: id)) { (response: WebServiceResponse<CharacterEntity>) in
                guard case .success(modelData: let entity) = response,
                      let model = try? entity?.toDomain() else {
                    completion(.failure(CharacterDetailProviderContractError.generic))
                    return
                }
                completion(.success(model))
            }
        } else {
            completion(.failure(CharacterDetailProviderContractError.noConnection))
        }
    }
}
