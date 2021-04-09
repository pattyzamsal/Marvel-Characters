//
//  CharacterDetailUseCase.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public protocol CharacterDetailUseCaseContract {
    func getCharacterDetail(id: String, completion: @escaping (Result<CharacterMarvel, Error>)  -> Void)
}

public enum CharacterDetailUseCaseError: Error {
    case generic
    case noConnection
}

public final class CharacterDetailUseCase {
    let provider: CharacterDetailProviderContract
    
    public init(provider: CharacterDetailProviderContract) {
        self.provider = provider
    }
}

extension CharacterDetailUseCase: CharacterDetailUseCaseContract {
    public func getCharacterDetail(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void) {
        return provider.getCharacterDetail(id: id, completion: completion)
    }
}
