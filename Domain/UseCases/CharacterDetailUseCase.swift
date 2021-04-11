//
//  CharacterDetailUseCase.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public protocol CharacterDetailUseCaseContract {
    func getCharacterDetailBy(id: String, completion: @escaping (Result<CharacterMarvel, Error>)  -> Void)
}

public enum CharacterDetailUseCaseError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public final class CharacterDetailUseCase {
    let provider: CharacterDetailProviderContract
    
    public init(provider: CharacterDetailProviderContract) {
        self.provider = provider
    }
}

extension CharacterDetailUseCase: CharacterDetailUseCaseContract {
    public func getCharacterDetailBy(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void) {
        return provider.getCharacterDetailBy(id: id) { (result) in
            switch result {
            case .success(let characterDetail):
                completion(.success(characterDetail))
            case .failure(let error):
                if let providerError = error as? CharacterDetailProviderContractError,
                   let message = providerError.errorDescription {
                    completion(.failure(CharacterDetailUseCaseError.generic(error: message)))
                }
            }
        }
    }
}
