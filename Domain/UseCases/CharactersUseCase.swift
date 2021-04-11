//
//  CharactersUseCase.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public protocol CharactersUseCaseContract {
    func getListCharacters(page: Int, completion: @escaping (Result<DataCharacters, Error>) -> Void)
}

public enum CharactersUseCaseError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public final class CharactersUseCase {
    let provider: CharactersProviderContract
    
    public init(provider: CharactersProviderContract) {
        self.provider = provider
    }
}

extension CharactersUseCase: CharactersUseCaseContract {
    public func getListCharacters(page: Int, completion: @escaping (Result<DataCharacters, Error>) -> Void) {
        return provider.getListCharacters(page: page) { (result) in
            switch result {
            case .success(let dataCharacters):
                completion(.success(dataCharacters))
            case .failure(let error):
                if let providerError = error as? CharactersProviderContractError,
                   let message = providerError.errorDescription {
                    completion(.failure(CharactersUseCaseError.generic(error: message)))
                }
            }
        }
    }
}
