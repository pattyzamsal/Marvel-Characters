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
    case generic
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
            case .failure:
                completion(.failure(CharactersUseCaseError.generic))
            }
        }
    }
}
