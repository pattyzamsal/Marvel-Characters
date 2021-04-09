//
//  CharactersProvider.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Domain
import Foundation

public class CharactersProvider {
    private let apiClient: APIClient
    
    public init() {
        apiClient = APIClient()
    }
}

extension CharactersProvider: CharactersProviderContract {
    public func getListCharacters(page: Int, completion: @escaping (Result<DataCharacters, Error>) -> Void) {
        apiClient.execute(endpoint: .getListCharacters(page: page)) { (response: WebServiceResponse<CharactersEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain() else {
                completion(.failure(CharactersProviderContractError.generic))
                return
            }
            completion(.success(model.data))
        }
    }
}
